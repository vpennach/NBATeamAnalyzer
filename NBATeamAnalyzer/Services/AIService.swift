import Foundation

enum AIProvider {
    case grok
    case chatGPT
}

class AIService: ObservableObject {
    @Published var isAnalyzing = false
    @Published var analysisResult: String = ""
    @Published var errorMessage: String = ""
    
    private let provider: AIProvider
    
    // Get API key from UserDefaults (set via SettingsView)
    private var apiKey: String {
        return UserDefaults.standard.string(forKey: "XAI_API_KEY") ?? ""
    }
    
    init(provider: AIProvider = .grok) {
        self.provider = provider
    }
    
    func analyzeTeams(_ teamConfigs: [TeamAnalysisConfig]) async {
        await MainActor.run {
            isAnalyzing = true
            analysisResult = ""
            errorMessage = ""
        }
        
        // Check if API key is available
        guard !apiKey.isEmpty else {
            await MainActor.run {
                self.errorMessage = "API key not found. Please set your API key in the Settings tab."
                self.isAnalyzing = false
            }
            return
        }
        
        let promptGenerator = AnalysisPrompt(teamConfigs: teamConfigs)
        let prompt = promptGenerator.generatePrompt()
        
        do {
            let result = try await callGrokAPI(prompt: prompt)
            await MainActor.run {
                self.analysisResult = result
                self.isAnalyzing = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = "Analysis failed: \(error.localizedDescription)"
                self.isAnalyzing = false
            }
        }
    }
    
    private func callGrokAPI(prompt: String) async throws -> String {
        let url = URL(string: "https://api.x.ai/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 3600 // 1 hour timeout
        
        // Create request body
        let requestBody: [String: Any] = [
            "messages": [
                [
                    "role": "system",
                    "content": "You are Grok, a highly intelligent, helpful AI assistant. When providing analysis, please format your response using markdown with clear headings and bullet points. Use # for main titles, ## for subtitles, ### for section headings, and • for bullet points. Do NOT use bold formatting (**text**) within paragraphs - only use bold for section headings. Keep the content clean and well-structured."
                ],
                [
                    "role": "user",
                    "content": prompt
                ]
            ],
            "model": "grok-4-latest",
            "stream": false,
            "temperature": 0
        ]
        
        // Convert to JSON
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        
        // Make the API call
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Check for HTTP errors
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "AIService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        guard httpResponse.statusCode == 200 else {
            let errorString = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NSError(domain: "AIService", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "API Error: \(errorString)"])
        }
        
        // Parse the response
        let responseDict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let choices = responseDict?["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw NSError(domain: "AIService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
        }
        
        return content
    }
    
    // Fallback mock implementation for testing
    private func mockAnalysis(prompt: String) async throws -> String {
        // Simulate API delay
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        
        // Return a mock analysis based on the prompt
        return """
        # NBA Team Analysis
        
        Based on your request, here's a comprehensive analysis of the selected teams:
        
        ## Performance Overview
        
        The analysis reveals fascinating insights about these teams during their specified periods. Each team demonstrated unique characteristics that defined their respective eras.
        
        ## Key Insights
        
        • **Team Dynamics**: Each team showed distinct playing styles and strategies
        • **Statistical Patterns**: Notable differences in scoring, defense, and efficiency
        • **Historical Context**: These periods represent significant moments in NBA history
        
        ## Comparative Analysis
        
        The teams you've selected represent different eras and playing styles, making this comparison particularly interesting for understanding how the game has evolved.
        
        *This is a mock analysis. In the full implementation, this would be generated by Grok based on the detailed prompt.*
        """
    }
} 
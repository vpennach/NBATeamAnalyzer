import SwiftUI

struct AnalysisResultsView: View {
    let teamConfigs: [TeamAnalysisConfig]
    @StateObject private var aiService = AIService()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            if aiService.isAnalyzing {
                loadingView
            } else if !aiService.analysisResult.isEmpty {
                analysisView
            } else if !aiService.errorMessage.isEmpty {
                errorView
            } else {
                startAnalysisView
            }
        }
        .navigationTitle("Analysis Results")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    dismiss()
                }
            }
            
            if !aiService.isAnalyzing && !aiService.analysisResult.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Share") {
                        // TODO: Implement share functionality
                    }
                }
            }
        }
        .onAppear {
            if aiService.analysisResult.isEmpty && aiService.errorMessage.isEmpty {
                Task {
                    await aiService.analyzeTeams(teamConfigs)
                }
            }
        }
    }
    
    private var startAnalysisView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 16) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                
                Text("Ready to Analyze")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Tap the button below to start the AI analysis")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await aiService.analyzeTeams(teamConfigs)
                }
            }) {
                HStack {
                    Text("Start Analysis")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.orange)
                
                Text("Analyzing Teams...")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("The AI is analyzing your selected teams and generating insights. This may take a few moments.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
    }
    
    private var analysisView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Analysis Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Analysis Complete")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("AI-generated insights based on your team selections")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.top)
                
                // Analysis Content with formatted display
                FormattedAnalysisView(content: aiService.analysisResult)
                    .padding(.horizontal)
                
                // Team Summary
                VStack(alignment: .leading, spacing: 12) {
                    Text("Teams Analyzed")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    ForEach(teamConfigs) { config in
                        HStack {
                            Image(config.team.logoName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(config.team.fullName)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Text("\(TeamAnalysisConfig.seasonDisplay(config.season)) • \(config.gameRangeDisplay)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
    
    private var errorView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                
                Text("Analysis Failed")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(aiService.errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await aiService.analyzeTeams(teamConfigs)
                }
            }) {
                Text("Try Again")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}

// MARK: - Formatted Analysis View
struct FormattedAnalysisView: View {
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(parseContent(), id: \.self) { section in
                switch section.type {
                case .title:
                    Text(section.text)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                    
                case .subtitle:
                    Text(section.text)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.top, 4)
                    
                case .heading:
                    Text(section.text)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.top, 12)
                    
                case .bullet:
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                            .font(.body)
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                        
                        Text(section.text)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 8)
                    
                case .paragraph:
                    FormattedParagraphView(text: section.text)
                        .lineSpacing(4)
                    
                case .emphasis:
                    Text(section.text)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.orange)
                    
                case .code:
                    Text(section.text)
                        .font(.system(.body, design: .monospaced))
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
    
    private func parseContent() -> [ContentSection] {
        var sections: [ContentSection] = []
        let lines = content.components(separatedBy: .newlines)
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            if trimmedLine.isEmpty { continue }
            
            if trimmedLine.hasPrefix("# ") {
                sections.append(ContentSection(type: .title, text: String(trimmedLine.dropFirst(2))))
            } else if trimmedLine.hasPrefix("## ") {
                sections.append(ContentSection(type: .subtitle, text: String(trimmedLine.dropFirst(3))))
            } else if trimmedLine.hasPrefix("### ") {
                sections.append(ContentSection(type: .heading, text: String(trimmedLine.dropFirst(4))))
            } else if trimmedLine.hasPrefix("• ") || trimmedLine.hasPrefix("- ") {
                sections.append(ContentSection(type: .bullet, text: String(trimmedLine.dropFirst(2))))
            } else if trimmedLine.hasPrefix("`") && trimmedLine.hasSuffix("`") {
                let codeText = String(trimmedLine.dropFirst().dropLast())
                sections.append(ContentSection(type: .code, text: codeText))
            } else {
                // Handle paragraphs with inline markdown formatting
                sections.append(ContentSection(type: .paragraph, text: trimmedLine))
            }
        }
        
        return sections
    }
}

// MARK: - Content Section Types
struct ContentSection: Hashable {
    let type: ContentType
    let text: String
    
    enum ContentType {
        case title
        case subtitle
        case heading
        case bullet
        case paragraph
        case emphasis
        case code
    }
}

// MARK: - Formatted Paragraph View
struct FormattedParagraphView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.body)
            .foregroundColor(.primary)
    }
}

#Preview {
    AnalysisResultsView(teamConfigs: [
        TeamAnalysisConfig(team: Team.allTeams[0], season: 2024, startGame: 1, endGame: 20),
        TeamAnalysisConfig(team: Team.allTeams[1], season: 2023, startGame: 1, endGame: 30)
    ])
} 
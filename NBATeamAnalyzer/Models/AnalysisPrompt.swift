import Foundation

struct AnalysisPrompt {
    let teamConfigs: [TeamAnalysisConfig]
    
    init(teamConfigs: [TeamAnalysisConfig]) {
        self.teamConfigs = teamConfigs
    }
    
    // Generate the main analysis prompt using the user's template
    func generatePrompt() -> String {
        var prompt = """
        You are an NBA analyst and you use basketball-reference.com to collect any statistics needed for your analysis.
        
        You are going to be comparing \(teamConfigs.count) NBA teams over a specific stretch of games within their season.
        
        The \(teamConfigs.count) teams and game stretches you will be analyzing are:
        
        """
        
        // Add each team's configuration
        for config in teamConfigs {
            prompt += """
            \(TeamAnalysisConfig.seasonDisplay(config.season)) \(config.team.fullName) games \(config.gameRangeDisplay)
            
            """
        }
        
        // Add analysis instructions
        prompt += """
        Provide a detailed analysis including:
        1. Who was the best team during their respective stretch and why
        2. Who was the best player on each team during their respective stretch
        3. Who was the best overall player during their respective stretch and why
        4. Strengths and Weaknesses of each team
        5. Any other interesting facts about these teams during those stretches
        
        Please format your response using markdown with clear headings, bullet points, and emphasis where appropriate. Use # for main titles, ## for subtitles, ### for section headings, • for bullet points, **bold** for emphasis, and ensure the content is well-structured and easy to read.
        
        Finally do not explain your reasonings to how you discovered your findings I want it presented as a quick and meaningful information about each analysis.
        """
        
        return prompt
    }
    
    // Generate a shorter prompt for quick analysis
    func generateQuickPrompt() -> String {
        var prompt = "Compare these NBA teams: "
        
        for (index, config) in teamConfigs.enumerated() {
            prompt += "\(config.team.name) (\(TeamAnalysisConfig.seasonDisplay(config.season)), \(config.gameRangeDisplay))"
            if index < teamConfigs.count - 1 {
                prompt += " vs "
            }
        }
        
        prompt += ". Provide a brief but insightful analysis of their performance, key differences, and what made each team special during these periods. Format your response using markdown with clear headings and bullet points for easy reading."
        
        return prompt
    }
} 
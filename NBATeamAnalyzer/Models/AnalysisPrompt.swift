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
        Please provide a detailed analysis with the following EXACT structure and formatting:
        
        # NBA Team Comparison Analysis
        
        ## Overview
        [Brief overview of the teams being compared and the analysis period]
        
        ## Best Team
        [Analysis of which team was the best during their respective stretch and why]
        
        ## Best Player on Each Team
        ### [Team Name 1]
        [Analysis of the best player on this team during their stretch]
        
        ### [Team Name 2]
        [Analysis of the best player on this team during their stretch]
        
        [Continue for each team...]
        
        ## Best Overall Player
        [Analysis of who was the best overall player across all teams and why]
        
        ## Strengths and Weaknesses of Each Team
        ### [Team Name 1] Strengths and Weaknesses
        [Analysis of this team's strengths and weaknesses during their stretch]
        
        ### [Team Name 2] Strengths and Weaknesses
        [Analysis of this team's strengths and weaknesses during their stretch]
        
        [Continue for each team...]
        
        ## Other Interesting Facts
        ### [Team Name 1]
        [Interesting facts about this team during their stretch]
        
        ### [Team Name 2]
        [Interesting facts about this team during their stretch]
        
        [Continue for each team...]
        
        IMPORTANT: Follow this EXACT structure with these EXACT section titles. Use # for main title, ## for major sections, and ### for subsections. Do NOT use bold formatting (**text**) within paragraphs - only use bold for section headings. Keep the content clean and well-structured.
        
        Do not explain your reasoning process - present the analysis as quick and meaningful information.
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
        
        prompt += ". Please provide a brief but insightful analysis with the following structure:\n\n# NBA Team Comparison Analysis\n\n## Overview\n[Brief overview]\n\n## Best Team\n[Analysis]\n\n## Best Player on Each Team\n### [Team Name]\n[Analysis]\n\n## Best Overall Player\n[Analysis]\n\n## Strengths and Weaknesses of Each Team\n### [Team Name] Strengths and Weaknesses\n[Analysis]\n\n## Other Interesting Facts\n### [Team Name]\n[Facts]\n\nUse # for main title, ## for major sections, and ### for subsections. Do NOT use bold formatting within paragraphs."
        
        return prompt
    }
} 
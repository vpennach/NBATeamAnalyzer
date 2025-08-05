import SwiftUI

struct PromptPreviewView: View {
    let teamConfigs: [TeamAnalysisConfig]
    @Environment(\.dismiss) private var dismiss
    
    private var generatedPrompt: String {
        let promptGenerator = AnalysisPrompt(teamConfigs: teamConfigs)
        return promptGenerator.generatePrompt()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 8) {
                Text("Generated Prompt")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("This is the prompt that will be sent to the AI")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            // Team Summary
            VStack(alignment: .leading, spacing: 12) {
                Text("Teams to Analyze")
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
            
            // Prompt Display
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("AI Prompt:")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                    
                    Text(generatedPrompt)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            
            // Action Buttons
            VStack(spacing: 12) {
                Button(action: {
                    // TODO: Send to Grok API
                }) {
                    HStack {
                        Text("Send to Grok API")
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
                .disabled(true) // Disabled for now
                
                Text("API integration coming soon...")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .padding(.bottom, 20)
        }
        .navigationTitle("Prompt Preview")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Copy") {
                    UIPasteboard.general.string = generatedPrompt
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PromptPreviewView(teamConfigs: [
            TeamAnalysisConfig(team: Team.allTeams[0], season: 2024, startGame: 1, endGame: 20),
            TeamAnalysisConfig(team: Team.allTeams[1], season: 2023, startGame: 1, endGame: 30)
        ])
    }
} 
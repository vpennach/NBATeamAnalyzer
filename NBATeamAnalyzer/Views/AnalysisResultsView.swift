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
                
                // Analysis Content
                Text(aiService.analysisResult)
                    .font(.body)
                    .lineSpacing(4)
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

#Preview {
    AnalysisResultsView(teamConfigs: [
        TeamAnalysisConfig(team: Team.allTeams[0], season: 2024, startGame: 1, endGame: 20),
        TeamAnalysisConfig(team: Team.allTeams[1], season: 2023, startGame: 1, endGame: 30)
    ])
} 
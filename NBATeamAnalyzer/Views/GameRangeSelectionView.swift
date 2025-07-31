import SwiftUI

struct GameRangeSelectionView: View {
    let selectedTeams: [Team]
    @State private var teamConfigs: [TeamAnalysisConfig] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Text("Configure Analysis")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Set season and game range for each team")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // Team Configuration Cards
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach($teamConfigs) { $config in
                            TeamAnalysisConfigCard(config: $config)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Analysis Summary
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.orange)
                        Text("Analysis Summary")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(teamConfigs) { config in
                            Text("• \(config.team.name): \(config.season) season, last \(config.gameRange) games")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                // Start Analysis Button
                VStack {
                    Button(action: {
                        // Will navigate to analysis view in next step
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
                    
                    Text("Comparing \(teamConfigs.count) teams across different seasons")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                .padding()
                .padding(.bottom, 20) // Extra padding for tab bar
            }
            .navigationTitle("Team Configuration")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Initialize team configs when view appears
                if teamConfigs.isEmpty {
                    teamConfigs = selectedTeams.map { team in
                        TeamAnalysisConfig(team: team)
                    }
                }
            }
        }
    }
}

#Preview {
    GameRangeSelectionView(selectedTeams: Array(Team.allTeams.prefix(3)))
} 
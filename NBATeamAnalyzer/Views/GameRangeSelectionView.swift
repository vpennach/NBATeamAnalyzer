import SwiftUI

struct GameRangeSelectionView: View {
    let selectedTeams: [Team]
    @State private var selectedGames: Int = 10
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Game Range")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("How many recent games to analyze?")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Selected Teams Summary
                VStack(alignment: .leading, spacing: 12) {
                    Text("Selected Teams")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                        ForEach(selectedTeams) { team in
                            HStack(spacing: 8) {
                                Image(team.logoName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                
                                Text(team.name)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Game Range Picker
                GameRangePicker(selectedGames: $selectedGames)
                    .padding(.horizontal)
                
                // Information about game range
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.orange)
                        Text("Analysis Information")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Analyzing \(selectedGames) most recent games")
                        Text("• Comparing \(selectedTeams.count) teams")
                        Text("• AI will provide performance insights")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                // Continue Button
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
                    
                    Text("This will analyze \(selectedGames) recent games for \(selectedTeams.count) teams")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                .padding()
            }
            .navigationTitle("Game Range")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    GameRangeSelectionView(selectedTeams: Array(Team.allTeams.prefix(3)))
} 
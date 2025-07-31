import SwiftUI

struct TeamAnalysisConfigCard: View {
    @Binding var config: TeamAnalysisConfig
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Team Header
            HStack(spacing: 12) {
                Image(config.team.logoName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(config.team.fullName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(TeamAnalysisConfig.seasonDisplay(config.season))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Season Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Season")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Picker("Season", selection: $config.season) {
                    ForEach(TeamAnalysisConfig.availableSeasons, id: \.self) { season in
                        Text(TeamAnalysisConfig.seasonDisplay(season)).tag(season)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // Quick Game Range Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Quick Ranges")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                    ForEach(TeamAnalysisConfig.commonRanges, id: \.0) { range in
                        Button(action: {
                            config.startGame = range.1
                            config.endGame = range.2
                        }) {
                            Text(range.0)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(isSelected(range) ? .white : .primary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(isSelected(range) ? Color.orange : Color(.systemGray5))
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            // Custom Game Range Input
            VStack(alignment: .leading, spacing: 8) {
                Text("Custom Range")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Start Game")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        TextField("1", value: $config.startGame, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("End Game")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        TextField("20", value: $config.endGame, format: .number)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Total")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(config.totalGames)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
    }
    
    private func isSelected(_ range: (String, Int, Int)) -> Bool {
        return config.startGame == range.1 && config.endGame == range.2
    }
}

#Preview {
    TeamAnalysisConfigCard(
        config: .constant(TeamAnalysisConfig(
            team: Team.allTeams[0],
            season: 2024,
            startGame: 1,
            endGame: 20
        ))
    )
    .padding()
} 
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
                    
                    Text("Season \(config.season)")
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
                        Text("\(season)").tag(season)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            // Game Range Selection
            VStack(alignment: .leading, spacing: 8) {
                Text("Games to Analyze")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack(spacing: 8) {
                    ForEach(TeamAnalysisConfig.defaultGameRanges, id: \.self) { games in
                        Button(action: {
                            config.gameRange = games
                        }) {
                            Text("\(games)")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(config.gameRange == games ? .white : .primary)
                                .frame(width: 45, height: 35)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(config.gameRange == games ? Color.orange : Color(.systemGray5))
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
                
                HStack {
                    Text("Last")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    TextField("20", value: $config.gameRange, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 60)
                        .keyboardType(.numberPad)
                    
                    Text("games")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
    }
}

#Preview {
    TeamAnalysisConfigCard(
        config: .constant(TeamAnalysisConfig(
            team: Team.allTeams[0],
            season: 2024,
            gameRange: 20
        ))
    )
    .padding()
} 
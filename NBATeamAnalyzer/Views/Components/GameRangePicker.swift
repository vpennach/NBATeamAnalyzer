import SwiftUI

struct GameRangePicker: View {
    @Binding var selectedGames: Int
    
    private let gameOptions = [5, 10, 15, 20]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Games to Analyze")
                .font(.headline)
                .fontWeight(.semibold)
            
            HStack(spacing: 12) {
                ForEach(gameOptions, id: \.self) { games in
                    Button(action: {
                        selectedGames = games
                    }) {
                        Text("\(games)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(selectedGames == games ? .white : .primary)
                            .frame(width: 50, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(selectedGames == games ? Color.orange : Color(.systemGray5))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    GameRangePicker(selectedGames: .constant(10))
        .padding()
} 
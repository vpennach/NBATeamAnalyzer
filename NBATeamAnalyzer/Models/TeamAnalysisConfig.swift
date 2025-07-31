import Foundation

struct TeamAnalysisConfig: Identifiable {
    let id = UUID()
    let team: Team
    var season: Int
    var startGame: Int
    var endGame: Int
    
    init(team: Team, season: Int = 2024, startGame: Int = 1, endGame: Int = 20) {
        self.team = team
        self.season = season
        self.startGame = startGame
        self.endGame = endGame
    }
    
    // Computed property for display
    var gameRangeDisplay: String {
        if startGame == 1 {
            return "Last \(endGame) games"
        } else {
            return "Games \(startGame)-\(endGame)"
        }
    }
    
    var totalGames: Int {
        return endGame - startGame + 1
    }
}

// Available seasons for analysis
extension TeamAnalysisConfig {
    static let availableSeasons: [Int] = {
        // NBA seasons from 1980 to current
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(1980...currentYear).reversed()
    }()
    
    // Format season for display (e.g., 2024 -> "2023-2024")
    static func seasonDisplay(_ year: Int) -> String {
        return "\(year-1)-\(year) season"
    }
    
    // Common game ranges for quick selection
    static let commonRanges: [(String, Int, Int)] = [
        ("Last 10 games", 1, 10),
        ("Last 20 games", 1, 20),
        ("Last 30 games", 1, 30),
        ("Last 50 games", 1, 50),
        ("Full season", 1, 82),
        ("Early season (1-25)", 1, 25),
        ("Mid season (26-50)", 26, 50),
        ("Late season (51-82)", 51, 82)
    ]
} 
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
    
    // Get the maximum games for a season
    var maxGamesForSeason: Int {
        switch season {
        case 1999: return 50  // 1998-99 lockout season
        case 2012: return 66  // 2011-12 lockout season  
        case 2020: return 65  // 2019-20 COVID shortened season
        default: return 82     // Regular season
        }
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
    
    // Get max games for a specific season
    static func maxGames(for season: Int) -> Int {
        switch season {
        case 1999: return 50  // 1998-99 lockout season
        case 2012: return 66  // 2011-12 lockout season
        case 2020: return 65  // 2019-20 COVID shortened season
        default: return 82     // Regular season
        }
    }
    
    // Common game ranges for quick selection
    static func commonRanges(for season: Int) -> [(String, Int, Int)] {
        let maxGames = maxGames(for: season)
        
        return [
            ("Full season", 1, maxGames),
            ("Early season (1-25)", 1, min(25, maxGames)),
            ("Mid season (26-50)", 26, min(50, maxGames)),
            ("Late season (51-82)", 51, maxGames),
            ("First 10", 1, min(10, maxGames)),
            ("Last 10", max(1, maxGames - 9), maxGames)
        ]
    }
} 
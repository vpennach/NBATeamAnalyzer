import Foundation

struct TeamAnalysisConfig: Identifiable {
    let id = UUID()
    let team: Team
    var season: Int
    var gameRange: Int
    
    init(team: Team, season: Int = 2024, gameRange: Int = 20) {
        self.team = team
        self.season = season
        self.gameRange = gameRange
    }
}

// Available seasons for analysis
extension TeamAnalysisConfig {
    static let availableSeasons: [Int] = {
        // NBA seasons from 1980 to current
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array(1980...currentYear).reversed()
    }()
    
    static let defaultGameRanges: [Int] = [10, 20, 30, 50, 82] // Common game ranges
} 
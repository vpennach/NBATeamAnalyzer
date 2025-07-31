import Foundation

struct Team: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let city: String
    let fullName: String
    let logoName: String
    
    // Computed property for display name
    var displayName: String {
        return "\(city) \(name)"
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
}

// Extension to provide all NBA teams
extension Team {
    static let allTeams: [Team] = [
        Team(name: "Hawks", city: "Atlanta", fullName: "Atlanta Hawks", logoName: "nba-atlanta-hawks-logo"),
        Team(name: "Celtics", city: "Boston", fullName: "Boston Celtics", logoName: "nba-boston-celtics-logo"),
        Team(name: "Nets", city: "Brooklyn", fullName: "Brooklyn Nets", logoName: "nba-brooklyn-nets-logo"),
        Team(name: "Hornets", city: "Charlotte", fullName: "Charlotte Hornets", logoName: "nba-charlotte-hornets-logo"),
        Team(name: "Bulls", city: "Chicago", fullName: "Chicago Bulls", logoName: "nba-chicago-bulls-logo"),
        Team(name: "Cavaliers", city: "Cleveland", fullName: "Cleveland Cavaliers", logoName: "nba-cleveland-cavaliers-logo"),
        Team(name: "Mavericks", city: "Dallas", fullName: "Dallas Mavericks", logoName: "nba-dallas-mavericks-logo"),
        Team(name: "Nuggets", city: "Denver", fullName: "Denver Nuggets", logoName: "nba-denver-nuggets-logo"),
        Team(name: "Pistons", city: "Detroit", fullName: "Detroit Pistons", logoName: "nba-detroit-pistons-logo"),
        Team(name: "Warriors", city: "Golden State", fullName: "Golden State Warriors", logoName: "nba-golden-state-warriors-logo"),
        Team(name: "Rockets", city: "Houston", fullName: "Houston Rockets", logoName: "nba-houston-rockets-logo"),
        Team(name: "Pacers", city: "Indiana", fullName: "Indiana Pacers", logoName: "nba-indiana-pacers-logo"),
        Team(name: "Clippers", city: "Los Angeles", fullName: "Los Angeles Clippers", logoName: "nba-los-angeles-clippers-logo"),
        Team(name: "Lakers", city: "Los Angeles", fullName: "Los Angeles Lakers", logoName: "nba-los-angeles-lakers-logo"),
        Team(name: "Grizzlies", city: "Memphis", fullName: "Memphis Grizzlies", logoName: "nba-memphis-grizzlies-logo"),
        Team(name: "Heat", city: "Miami", fullName: "Miami Heat", logoName: "nba-miami-heat-logo"),
        Team(name: "Bucks", city: "Milwaukee", fullName: "Milwaukee Bucks", logoName: "nba-milwaukee-bucks-logo"),
        Team(name: "Timberwolves", city: "Minnesota", fullName: "Minnesota Timberwolves", logoName: "nba-minnesota-timberwolves-logo"),
        Team(name: "Pelicans", city: "New Orleans", fullName: "New Orleans Pelicans", logoName: "nba-new-orleans-pelicans-logo"),
        Team(name: "Knicks", city: "New York", fullName: "New York Knicks", logoName: "nba-new-york-knicks-logo"),
        Team(name: "Thunder", city: "Oklahoma City", fullName: "Oklahoma City Thunder", logoName: "nba-oklahoma-city-thunder-logo"),
        Team(name: "Magic", city: "Orlando", fullName: "Orlando Magic", logoName: "nba-orlando-magic-logo"),
        Team(name: "76ers", city: "Philadelphia", fullName: "Philadelphia 76ers", logoName: "nba-philadelphia-76ers-logo"),
        Team(name: "Suns", city: "Phoenix", fullName: "Phoenix Suns", logoName: "nba-phoenix-suns-logo"),
        Team(name: "Trail Blazers", city: "Portland", fullName: "Portland Trail Blazers", logoName: "nba-portland-trail-blazers-logo"),
        Team(name: "Kings", city: "Sacramento", fullName: "Sacramento Kings", logoName: "nba-sacramento-kings-logo"),
        Team(name: "Spurs", city: "San Antonio", fullName: "San Antonio Spurs", logoName: "nba-san-antonio-spurs-logo"),
        Team(name: "Raptors", city: "Toronto", fullName: "Toronto Raptors", logoName: "nba-toronto-raptors-logo"),
        Team(name: "Jazz", city: "Utah", fullName: "Utah Jazz", logoName: "nba-utah-jazz-logo"),
        Team(name: "Wizards", city: "Washington", fullName: "Washington Wizards", logoName: "nba-washington-wizards-logo")
    ]
} 
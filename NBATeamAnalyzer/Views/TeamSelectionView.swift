import SwiftUI

struct TeamSelectionView: View {
    @State private var selectedTeams: Set<Team> = []
    @State private var searchText = ""
    
    // Filtered teams based on search
    private var filteredTeams: [Team] {
        if searchText.isEmpty {
            return Team.allTeams
        } else {
            return Team.allTeams.filter { team in
                team.name.localizedCaseInsensitiveContains(searchText) ||
                team.city.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text("Select Teams")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Choose 2-4 teams to compare")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search teams...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Selection Counter
                HStack {
                    Text("\(selectedTeams.count) of 4 teams selected")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if !selectedTeams.isEmpty {
                        Button("Clear All") {
                            selectedTeams.removeAll()
                        }
                        .font(.caption)
                        .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Team Grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3), spacing: 16) {
                        ForEach(filteredTeams) { team in
                            TeamCard(
                                team: team,
                                isSelected: selectedTeams.contains(team)
                            ) {
                                toggleTeamSelection(team)
                            }
                        }
                    }
                    .padding()
                }
                
                // Compare Button
                VStack {
                    Button(action: {
                        // Will be implemented in next step
                    }) {
                        HStack {
                            Text("Compare Teams")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            if selectedTeams.count >= 2 {
                                Text("(\(selectedTeams.count))")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedTeams.count >= 2 ? Color.orange : Color.gray)
                        .cornerRadius(12)
                    }
                    .disabled(selectedTeams.count < 2)
                    
                    if selectedTeams.count < 2 {
                        Text("Select at least 2 teams to continue")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                }
                .padding()
            }
            .navigationTitle("Team Selection")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func toggleTeamSelection(_ team: Team) {
        if selectedTeams.contains(team) {
            selectedTeams.remove(team)
        } else if selectedTeams.count < 4 {
            selectedTeams.insert(team)
        }
    }
}

#Preview {
    TeamSelectionView()
} 
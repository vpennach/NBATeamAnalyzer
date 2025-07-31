import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            TeamSelectionView()
                .tabItem {
                    Image(systemName: "basketball.fill")
                    Text("Analyze")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    ContentView()
} 
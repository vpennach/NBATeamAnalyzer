import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section(header: Text("Notifications")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Vincent Pennachio")
                            .foregroundColor(.secondary)
                    }
                }
                
                Section(header: Text("Development")) {
                    HStack {
                        Text("Current Phase")
                        Spacer()
                        Text("Step 1 - Foundation")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Next Step")
                        Spacer()
                        Text("Team Selection UI")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
} 
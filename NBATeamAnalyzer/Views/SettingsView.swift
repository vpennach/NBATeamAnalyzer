import SwiftUI

struct SettingsView: View {
    @State private var apiKey: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "gear")
                        .font(.system(size: 60))
                        .foregroundColor(.orange)
                    
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Configure your app settings")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)
                
                // API Key Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("xAI API Configuration")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("API Key")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        SecureField("Enter your xAI API key", text: $apiKey)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onAppear {
                                // Load existing API key
                                apiKey = UserDefaults.standard.string(forKey: "XAI_API_KEY") ?? ""
                            }
                        
                        Text("Your API key is stored securely and never shared.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: saveAPIKey) {
                        Text("Save API Key")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // App Info
                VStack(alignment: .leading, spacing: 12) {
                    Text("App Information")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        InfoRow(title: "Version", value: "1.0.0")
                        InfoRow(title: "Developer", value: "Vincent Pennachio")
                        InfoRow(title: "API Provider", value: "xAI (Grok)")
                    }
                }
                .padding()
                .background(Color(.systemGray6).opacity(0.3))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("API Key", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func saveAPIKey() {
        if apiKey.isEmpty {
            alertMessage = "Please enter your API key."
            showingAlert = true
            return
        }
        
        if !apiKey.hasPrefix("xai-") {
            alertMessage = "API key should start with 'xai-'"
            showingAlert = true
            return
        }
        
        UserDefaults.standard.set(apiKey, forKey: "XAI_API_KEY")
        alertMessage = "API key saved successfully!"
        showingAlert = true
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    SettingsView()
} 
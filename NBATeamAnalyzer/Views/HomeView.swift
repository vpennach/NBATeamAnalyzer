import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // App Logo/Title
                VStack(spacing: 16) {
                    Image(systemName: "basketball.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.orange)
                    
                    Text("NBA Team Analyzer - Test")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("AI-Powered Team Performance Analysis")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // App Description
                VStack(spacing: 12) {
                    FeatureRow(icon: "chart.bar.fill", title: "Compare Teams", description: "Select 2-4 teams to analyze")
                    FeatureRow(icon: "clock.fill", title: "Custom Time Range", description: "Analyze 5-20 recent games")
                    FeatureRow(icon: "brain.head.profile", title: "AI Insights", description: "Get intelligent performance analysis")
                }
                
                Spacer()
                
                // Get Started Button
                NavigationLink(destination: TeamSelectionView()) {
                    HStack {
                        Text("Start Analysis")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.orange)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
} 
# NBA Team Analyzer

A modern iOS application that leverages AI to provide intelligent analysis of NBA team performance comparisons across different eras and seasons. Built with SwiftUI and designed to demonstrate advanced iOS development practices.

## Features

### **Team Selection & Configuration**
- **30 NBA Teams**: Complete roster with team logos and names
- **Multi-Team Comparison**: Select 2-4 teams for analysis
- **Advanced Season Selection**: Analyze any season from 1980-2024
- **Flexible Game Ranges**: Custom game ranges or quick selections

### **Smart Game Range System**
- **Quick Ranges**: Full season, Early/Mid/Late season, First/Last 10 games
- **Custom Ranges**: Specify exact game numbers (e.g., games 17-67)
- **Lockout Season Support**: Handles lockout seasons 1998-99 (50 games), 2011-12 (66 games), and COVID season 2019-20 (65 games)
- **Validation**: Prevents invalid game ranges and season mismatches

### **AI-Powered Analysis**
- **Intelligent Prompt Generation**: Creates detailed analysis requests
- **Cross-Era Comparisons**: Compare teams from different seasons
- **Comprehensive Insights**: Best team, best players, strengths/weaknesses
- **Historical Context**: Places analysis in broader NBA history

## Technical Stack

### **iOS Development**
- **SwiftUI**: Modern declarative UI framework
- **Swift**: Latest language features and concurrency
- **Xcode**: Professional iOS development environment
- **Asset Catalog**: Professional image management

### **Architecture & State Management**
- **ObservableObject**: Reactive state management
- **Async/Await**: Modern Swift concurrency
- **Custom Components**: Reusable UI components
- **Navigation**: TabView and NavigationView flows

### **AI Integration**
- **Prompt Engineering**: Sophisticated template system
- **API Service Layer**: Ready for Grok/ChatGPT integration
- **Error Handling**: Comprehensive error states and retry mechanisms

### **Version Control**
- **Git**: Distributed version control
- **GitHub**: Remote repository management
- **Multi-IDE Workflow**: Cursor + Xcode development 

## User Experience

1. **Home Screen**: Clean interface with app overview and "Start Analysis" button
2. **Team Selection**: Browse 30 NBA teams with search functionality
3. **Team Configuration**: Set season and game range for each team individually
4. **AI Analysis**: Automatic prompt generation and analysis processing
5. **Results Display**: Formatted analysis with team summaries and insights

## Example Analysis

**Comparing 1996-97 Bulls (games 1-25) vs 2016-17 Warriors (games 60-82):**

- **Best Team**: 1996-97 Bulls during their stretch
- **Best Players**: Michael Jordan (Bulls), Stephen Curry (Warriors)
- **Strengths**: Bulls' defensive dominance, Warriors' three-point shooting
- **Historical Context**: Different eras of NBA basketball evolution

## 🚀 Setup Instructions

### **Prerequisites**
- macOS with Xcode 15.0 or later
- iOS Simulator or physical iOS device
- Git for version control

### **Installation Steps**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/vpennach/NBATeamAnalyzer.git
   cd NBATeamAnalyzer
   ```

2. **Open in Xcode**
   ```bash
   open NBATeamAnalyzer.xcodeproj
   ```

3. **Build and Run**
   - Select your target device (iOS Simulator recommended)
   - Press `⌘ + R` or click the "Run" button
   - The app will build and launch in the simulator

### **Testing the App**

1. **Navigate the Flow**:
   - Tap "Start Analysis" on the home screen
   - Select 2-4 teams from the grid
   - Tap "Compare Teams" to proceed

2. **Configure Analysis**:
   - Choose seasons for each team (1980-2024)
   - Select game ranges (quick options or custom)
   - Tap "Start Analysis" to generate AI insights

3. **View Results**:
   - Wait for the 2-second mock analysis
   - Review the formatted analysis results
   - Check the team summary at the bottom

## Contributing

This is a personal project for learning and portfolio development. The codebase demonstrates modern iOS development practices and AI integration concepts.

## License

This project is for educational and portfolio purposes.


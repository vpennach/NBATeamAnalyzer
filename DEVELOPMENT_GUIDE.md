# NBA Team Analyzer - Development Guide

## Project Overview
SwiftUI app for comparing NBA teams using AI analysis. Built with modern iOS development practices.

## Key Lessons Learned

### Xcode Project Setup
- **Folder-based projects** work best for file syncing
- **Create project IN existing folder** to avoid duplication
- **Use folder references** (blue folders) not groups (yellow folders)
- **Always pull before editing** to avoid conflicts

### File Structure
```
team-performance-analyzer/
├── NBATeamAnalyzer.xcodeproj/
├── ContentView.swift
├── NBATeamAnalyzerApp.swift
├── Views/
│   ├── HomeView.swift
│   ├── TeamSelectionView.swift
│   ├── SettingsView.swift
│   └── Components/
│       ├── TeamCard.swift
│       └── GameRangePicker.swift
├── Models/
│   └── Team.swift
└── nba-logos/
    └── (30 NBA team logos)
```

### Development Workflow
1. **Develop in Cursor** - Make changes and commit
2. **Push to GitHub** - Version control
3. **Pull in Xcode** - Test and build
4. **Repeat** - Iterative development

### SwiftUI Concepts Learned
- `@State` for local view state
- `LazyVGrid` for efficient layouts
- Custom components with `@Binding`
- Animations with `.animation()`
- Conditional styling based on state

### Common Issues & Solutions
- **Corrupted .xcodeproj**: Delete and recreate
- **File sync issues**: Use folder references, not groups
- **Build errors**: Clean build folder (`Product → Clean Build Folder`)
- **Missing files**: Add to root project, not subfolders

### Step-by-Step Project Creation
1. Create new iOS project in existing folder
2. Delete default files
3. Add existing Swift files to root project
4. Add assets (logos) to project
5. Set up Git repository
6. Test build and run

### Testing & Debugging
- Use Xcode simulator for testing
- SwiftUI previews for rapid iteration
- `Cmd + R` for quick rebuilds
- Check console for build errors

## Future Development Steps
- Step 3: Game range selection
- Step 4: API integration
- Step 5: AI analysis
- Step 6: Polish and testing

## Technologies Used
- SwiftUI
- Swift Concurrency (async/await)
- Combine (reactive programming)
- Core Data (local storage)
- Git for version control

## Resume Impact
This project demonstrates:
- Modern iOS development with SwiftUI
- API integration and data processing
- AI implementation
- Clean architecture and state management
- Version control and collaborative development 
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TodayView().tabItem { Label("tab.today", systemImage: "sun.max") }
            TracksView().tabItem { Label("tab.tracks", systemImage: "square.grid.2x2") }
            ProgressViewScreen().tabItem { Label("tab.progress", systemImage: "chart.bar") }
            SettingsViewScreen().tabItem { Label("tab.settings", systemImage: "gearshape") }
        }
    }
}

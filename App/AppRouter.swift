import SwiftUI

struct AppRouter: View {
    var body: some View {
        TabView {
            NavigationStack {
                PlayContainerView()
            }
            .tabItem { Label("Play", systemImage: "gamecontroller") }

            NavigationStack {
                HomeView()
            }
            .tabItem { Label("Home", systemImage: "house") }

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Options", systemImage: "gearshape") }
        }
    }
}

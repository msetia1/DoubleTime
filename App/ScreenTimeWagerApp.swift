import SwiftUI

@main
struct DoubleTimeApp: App {
    @State private var appModel = AppModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .environment(appModel)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                Task {
                    await appModel.refreshUsageAndRecomputeRemaining()
                }
            }
        }
    }
}

import SwiftUI

@main
struct DoubleTimeApp: App {
    @State private var appModel = AppModel()
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            VStack(spacing: 12) {
                Text("\(appModel.remainingMinutes)")
                    .font(Typography.Token.heroMetric())
                    .foregroundStyle(.primary)
                Text("minutes remaining")
                    .font(Typography.Token.secondary())
                    .foregroundStyle(.secondary)
            }
            .onAppear {
                appModel.checkDayReset()
                Task {
                    await appModel.refreshUsageAndRecomputeRemaining()
                }
            }
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

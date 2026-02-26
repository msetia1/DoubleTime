import SwiftUI

@main
struct DoubleTimeApp: App {
    @State private var appModel = AppModel()

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
            }
        }
        .environment(appModel)
    }
}

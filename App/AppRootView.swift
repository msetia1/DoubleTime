import SwiftUI

struct AppRootView: View {
    @Environment(AppModel.self) private var appModel

    var body: some View {
        AppRouter()
            .onAppear {
                appModel.checkDayReset()
                Task {
                    await appModel.refreshUsageAndRecomputeRemaining()
                }
            }
    }
}

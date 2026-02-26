import SwiftUI
import FamilyControls

@Observable
final class SettingsViewModel {

    private let appModel: AppModel
    var isAuthorized: Bool

    init(appModel: AppModel) {
        self.appModel = appModel
        self.isAuthorized = appModel.isScreenTimeAuthorized
    }

    // MARK: - Authorization

    @discardableResult
    func requestAuthorization() async -> Bool {
        let result = await appModel.requestScreenTimeAuthorization()
        isAuthorized = appModel.isScreenTimeAuthorized
        return result
    }

    // MARK: - App Selection

    var hasSelection: Bool { appModel.hasAppSelection }

    var selection: FamilyActivitySelection { appModel.appSelection }

    func updateSelection(_ newSelection: FamilyActivitySelection) {
        appModel.updateAppSelection(newSelection)
    }
}

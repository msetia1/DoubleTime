// Stub generated for project scaffolding. Implement later.
import SwiftUI

@Observable
final class MinesViewModel {

    private let appModel: AppModel
    private let engine = MinesEngine()

    init(appModel: AppModel) {
        self.appModel = appModel
    }

    // TODO: Wager selection state
    // TODO: Game start / resolve actions
    // TODO: Apply result via appModel.applyGameResult
}

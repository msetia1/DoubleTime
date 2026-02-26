// Stub generated for project scaffolding. Implement later.
import SwiftUI

/// Branded lock/unlock button using `BrandedActionButtonStyle`.
///
/// Wraps the styling contract from `Docs/styling.md`.
/// See also: `LockToggleButton` for the full interactive component.
struct BrandLockButton: View {
    let title: String
    let state: BrandedActionStyleState
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(BrandedActionButtonStyle(state: state))
    }
}

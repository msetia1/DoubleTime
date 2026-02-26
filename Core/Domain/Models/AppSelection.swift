import Foundation

/// Lightweight domain flag for whether the user has selected apps to restrict.
/// The actual opaque FamilyControls tokens live in AppSelectionService.
struct AppSelection {
    var hasSelection: Bool = false
}

import Foundation

/// Lightweight representation of which apps the user has selected for restriction.
/// The actual FamilyControls selection is handled in Services/ScreenTime.
struct AppSelection: Codable {
    var applicationTokens: Set<String>

    var isEmpty: Bool { applicationTokens.isEmpty }

    static let empty = AppSelection(applicationTokens: [])
}

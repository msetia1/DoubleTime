import Foundation
import FamilyControls
import ManagedSettings

final class AppSelectionService {

    private static let storageKey = "familyActivitySelection"

    var selection: FamilyActivitySelection {
        get {
            guard let data = UserDefaults.standard.data(forKey: Self.storageKey),
                  let decoded = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
            else { return FamilyActivitySelection() }
            return decoded
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: Self.storageKey)
            }
        }
    }

    var hasSelection: Bool {
        !selection.applicationTokens.isEmpty
    }

    var applicationTokens: Set<ApplicationToken> {
        selection.applicationTokens
    }
}

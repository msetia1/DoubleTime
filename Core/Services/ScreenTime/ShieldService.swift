import ManagedSettings

final class ShieldService {

    private let store = ManagedSettingsStore()

    func applyShields(for tokens: Set<ApplicationToken>) {
        store.shield.applications = tokens
    }

    func clearShields() {
        store.shield.applications = nil
    }
}

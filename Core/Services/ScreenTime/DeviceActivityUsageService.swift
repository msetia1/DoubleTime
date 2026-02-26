import DeviceActivity
import ManagedSettings

final class DeviceActivityUsageService {

    func fetchUsageMinutesToday(for tokens: Set<ApplicationToken>) async -> Int {
        // DeviceActivityCenter usage queries require a DeviceActivityReport extension.
        // Until the report extension is built, return 0 so the app compiles and runs.
        return 0
    }
}

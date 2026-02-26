import Foundation

@Observable
final class UsageModel {
    var usageMinutesToday: Int = 0
    var lastUsageRefreshDate: Date? = nil
}

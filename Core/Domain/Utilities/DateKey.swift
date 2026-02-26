import Foundation

enum DateKey {
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f
    }()

    /// Returns today's date as "yyyy-MM-dd" for day-reset detection.
    static func today() -> String {
        formatter.string(from: Date())
    }

    /// Returns the date key for a given date.
    static func key(for date: Date) -> String {
        formatter.string(from: date)
    }
}

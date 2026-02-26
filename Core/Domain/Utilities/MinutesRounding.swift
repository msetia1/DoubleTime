import Foundation

enum MinutesRounding {
    /// Converts seconds to whole minutes using floor division.
    static func floorToMinutes(_ seconds: Double) -> Int {
        Int(floor(seconds / 60.0))
    }
}

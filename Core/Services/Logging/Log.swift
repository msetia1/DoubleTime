// Stub generated for project scaffolding. Implement later.
import Foundation
import os

enum Log {
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.personal.DoubleTime"

    static let screenTime = Logger(subsystem: subsystem, category: "ScreenTime")
    static let shield     = Logger(subsystem: subsystem, category: "Shield")
    static let usage      = Logger(subsystem: subsystem, category: "Usage")
    static let budget     = Logger(subsystem: subsystem, category: "Budget")
    static let games      = Logger(subsystem: subsystem, category: "Games")
}

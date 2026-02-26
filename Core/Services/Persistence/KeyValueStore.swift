import Foundation

/// Protocol for key-value persistence. Like localStorage in JS.
protocol KeyValueStore {
    func set(_ value: Int, forKey key: String)
    func set(_ value: String, forKey key: String)
    func set(_ value: Bool, forKey key: String)
    func integer(forKey key: String) -> Int?
    func string(forKey key: String) -> String?
    func bool(forKey key: String) -> Bool
    func remove(forKey key: String)
    func setCodable<T: Encodable>(_ value: T, forKey key: String)
    func codable<T: Decodable>(forKey key: String) -> T?
}

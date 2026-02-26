import Foundation

/// Concrete KeyValueStore backed by UserDefaults.
final class UserDefaultsStore: KeyValueStore {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func set(_ value: Int, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func set(_ value: Bool, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    func integer(forKey key: String) -> Int? {
        defaults.object(forKey: key) != nil ? defaults.integer(forKey: key) : nil
    }

    func string(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }

    func bool(forKey key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }

    func setCodable<T: Encodable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            defaults.set(data, forKey: key)
        }
    }

    func codable<T: Decodable>(forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

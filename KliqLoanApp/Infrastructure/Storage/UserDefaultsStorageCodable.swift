//
//  UserDefaultsStorageCodable.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

@propertyWrapper
public struct UserDefaultsStorageCodable<T: Codable> {
    private let key: String
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    public init(key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            return try? decoder.decode(T.self, from: data)
        }
        set {
            guard let value = newValue else {
                UserDefaults.standard.removeObject(forKey: key)
                return
            }
            if let encoded = try? encoder.encode(value) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

//
//  KeychainStorage.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

@propertyWrapper
public struct KeychainStorage<T: Codable> {
    private let key: String
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    public init(key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            guard let data = KeychainManager.load(forKey: key) else { return nil }
            return try? decoder.decode(T.self, from: data)
        }
        set {
            guard let value = newValue, let data = try? encoder.encode(value) else {
                KeychainManager.delete(forKey: key)
                return
            }
            KeychainManager.save(data, forKey: key)
        }
    }
}

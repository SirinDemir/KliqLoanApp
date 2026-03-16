//
//  KeychainManager.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation
import Security

public struct KeychainManagerConfig {
    public let serviceIdentifier: String?

    public init(serviceIdentifier: String? = nil) {
        self.serviceIdentifier = serviceIdentifier
    }
}

public enum KeychainManager {
    private static var serviceIdentifier = "com.kliqloan.app"

    public static func configure(with config: KeychainManagerConfig) {
        serviceIdentifier = config.serviceIdentifier ?? "com.kliqloan.app"
    }

    public static func save(_ data: Data, forKey key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceIdentifier,
            kSecAttrAccount: key,
            kSecValueData: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            update(data, forKey: key)
        }
        // status != errSecSuccess durumunda production'da log/crash raporu tercih edilebilir
    }

    public static func load(forKey key: String) -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceIdentifier,
            kSecAttrAccount: key,
            kSecMatchLimit: kSecMatchLimitOne,
            kSecReturnData: kCFBooleanTrue as Any
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let data = result as? Data else {
            return nil
        }
        return data
    }

    public static func delete(forKey key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceIdentifier,
            kSecAttrAccount: key
        ]

        _ = SecItemDelete(query as CFDictionary)
        // errSecSuccess / errSecItemNotFound dışı durumlarda isteğe bağlı log
    }

    private static func update(_ data: Data, forKey key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: serviceIdentifier,
            kSecAttrAccount: key
        ]

        let attributes: [CFString: Any] = [
            kSecValueData: data
        ]

        _ = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        // status != errSecSuccess isteğe bağlı log
    }
}

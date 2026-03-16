//
//  SessionStorage.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol UserStorable: AnyObject {
    var user: User? { get }
    func saveUser(_ user: User?)
    func deleteUser()
}

public protocol TokenStorable: AnyObject {
    var token: Token? { get }
    func saveToken(_ token: Token?)
    func deleteToken()
}

public final class SessionStorage: SessionStorageProtocol, UserStorable, TokenStorable {
    private enum Key: String {
        case isLoggedIn
        case user
        case token

        func fullPath() -> String {
            "\(SessionStorage.self).\(rawValue)"
        }
    }

    @UserDefaultsStorage(key: Key.isLoggedIn.fullPath(), defaultValue: false)
    private var storedIsLoggedIn: Bool

    @UserDefaultsStorageCodable(key: Key.user.fullPath())
    private(set) public var user: User?

    @KeychainStorage(key: Key.token.fullPath())
    private(set) public var token: Token?

    public var isLoggedIn: Bool {
        storedIsLoggedIn
    }

    public init() {}

    public func setLoggedIn(_ value: Bool) {
        storedIsLoggedIn = value
    }

    public func saveUser(_ user: User?) {
        self.user = user
    }

    public func deleteUser() {
        self.user = nil
    }

    public func saveToken(_ token: Token?) {
        self.token = token
    }

    public func deleteToken() {
        self.token = nil
    }

    public func clearSession() {
        deleteToken()
        deleteUser()
        setLoggedIn(false)
    }
}

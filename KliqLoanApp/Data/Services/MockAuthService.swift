//
//  MockAuthService.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class MockAuthService: AuthServiceProtocol {
    private let sessionStorage: SessionStorageProtocol
    
    public init(sessionStorage: SessionStorageProtocol) {
        self.sessionStorage = sessionStorage
    }
    
    public var isLoggedIn: Bool {
        sessionStorage.isLoggedIn
    }
    
    public func login(email: String, password: String) async throws -> Bool {
        try await Task.sleep(nanoseconds: 500_000_000)
        sessionStorage.setLoggedIn(true)
        return true
    }
    
    public func logout() async {
        sessionStorage.clearSession()
    }
}

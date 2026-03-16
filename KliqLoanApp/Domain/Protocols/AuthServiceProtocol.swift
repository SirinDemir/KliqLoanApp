//
//  AuthServiceProtocol.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> Bool
    func logout() async
    var isLoggedIn: Bool { get }
}

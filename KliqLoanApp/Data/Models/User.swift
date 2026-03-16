//
//  User.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct User: Codable, Equatable {
    public let username: String
    public let email: String

    public init(username: String, email: String) {
        self.username = username
        self.email = email
    }
}

//
//  Token.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct Token: Codable, Equatable {
    public let accessToken: String
    public let accessTokenExpiration: String
    public let refreshToken: String
    public let refreshTokenExpiration: String

    public init(
        accessToken: String,
        accessTokenExpiration: String,
        refreshToken: String,
        refreshTokenExpiration: String
    ) {
        self.accessToken = accessToken
        self.accessTokenExpiration = accessTokenExpiration
        self.refreshToken = refreshToken
        self.refreshTokenExpiration = refreshTokenExpiration
    }
}

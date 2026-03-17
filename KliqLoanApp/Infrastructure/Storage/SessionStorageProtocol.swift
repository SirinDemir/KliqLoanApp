//
//  SessionStorageProtocol.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol SessionStorageProtocol {
    var isLoggedIn: Bool { get }
    func setLoggedIn(_ value: Bool)
    func clearSession()
}

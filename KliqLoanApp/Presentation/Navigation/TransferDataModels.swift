//
//  TransferDataModels.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct UserTransferData: ModelTransferable {
    public let email: String
    public let username: String?

    public init(email: String, username: String? = nil) {
        self.email = email
        self.username = username
    }

    public func describe() -> String {
        "UserTransferData: \(email)"
    }
}

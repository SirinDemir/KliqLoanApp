//
//  ValidationHandler.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol ValidationHandler {
    func validateText(_ text: String?, with provider: ValidationProvider) -> ValidationResult
}

extension ValidationHandler {
    public func validateText(_ text: String?, with provider: ValidationProvider) -> ValidationResult {
        provider.validate(text)
    }
}

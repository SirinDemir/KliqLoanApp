//
//  EmailValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class EmailValidationProvider: ValidationProvider {
    private let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    
    public init() {}
    
    public func validate(_ text: String?) -> ValidationResult {
        ValidationResult.validateRegex(text, regex: emailRegex, failureMessage: "Invalid email format")
    }
}

//
//  MinLengthValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class MinLengthValidationProvider: ValidationProvider {
    private let minLength: Int
    private let fieldName: String
    
    public init(minLength: Int, fieldName: String = "Password") {
        self.minLength = minLength
        self.fieldName = fieldName
    }
    
    public func validate(_ text: String?) -> ValidationResult {
        guard let text = text else { return .failure("\(fieldName) is required") }
        guard text.count >= minLength else {
            return .failure("\(fieldName) must be at least \(minLength) characters")
        }
        return .success
    }
}

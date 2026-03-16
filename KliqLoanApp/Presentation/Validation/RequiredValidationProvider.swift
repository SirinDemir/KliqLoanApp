//
//  RequiredValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class RequiredValidationProvider: ValidationProvider {
    private let fieldName: String
    
    public init(fieldName: String = "Field") {
        self.fieldName = fieldName
    }
    
    public func validate(_ text: String?) -> ValidationResult {
        guard let text = text, !text.isConsideredEmpty else {
            return .failure("\(fieldName) is required")
        }
        return .success
    }
}

//
//  EmptyValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class EmptyValidationProvider: ValidationProvider {
    private let failureMessage: String
    
    public init(failureMessage: String = "Input is empty") {
        self.failureMessage = failureMessage
    }
    
    public func validate(_ text: String?) -> ValidationResult {
        guard let text = text, !text.isConsideredEmpty else {
            return .failure(failureMessage)
        }
        return .success
    }
}

//
//  CountValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class CountValidationProvider: ValidationProvider {
    private let minLength: Int
    private let maxLength: Int
    private let failureMessage: String
    
    public init(minLength: Int, maxLength: Int = Int.max, failureMessage: String? = nil) {
        self.minLength = minLength
        self.maxLength = maxLength
        self.failureMessage = failureMessage ?? "Input must be between \(minLength) and \(maxLength) characters"
    }
    
    public func validate(_ text: String?) -> ValidationResult {
        guard let text = text else { return .failure("Input is nil") }
        let count = text.count
        guard count >= minLength, count <= maxLength else {
            return .failure(failureMessage)
        }
        return .success
    }
}

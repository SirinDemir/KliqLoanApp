//
//  ValidationResult.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public enum ValidationResult: Equatable {
    case success
    case failure(String)
    
    public var isValid: Bool {
        if case .success = self { return true }
        return false
    }
    
    public var errorMessage: String? {
        if case let .failure(message) = self { return message }
        return nil
    }
    
    public static func validateRegex(_ text: String?, regex: String, failureMessage: String = "Invalid format") -> ValidationResult {
        guard let text = text else { return .failure("Input is nil") }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text) ? .success : .failure(failureMessage)
    }
}

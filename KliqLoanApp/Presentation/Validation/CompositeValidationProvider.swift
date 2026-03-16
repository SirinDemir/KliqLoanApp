//
//  CompositeValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class CompositeValidationProvider: ValidationProvider {
    private let providers: [ValidationProvider]
    
    public init(providers: [ValidationProvider]) {
        self.providers = providers
    }
    
    public func validate(_ text: String?) -> ValidationResult {
        for provider in providers {
            let result = provider.validate(text)
            if !result.isValid {
                return result
            }
        }
        return .success
    }
}

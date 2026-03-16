//
//  ValidationProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol ValidationProvider {
    func validate(_ text: String?) -> ValidationResult
}

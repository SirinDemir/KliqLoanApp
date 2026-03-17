//
//  String+EmptyState.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

extension String {

    public static var empty: String { "" }

    public enum EmptyState {
        case empty
        case dot
        case whitespace
        case nonEmpty
    }

    public var emptyState: EmptyState {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            return isEmpty ? .empty : .whitespace
        }
        if trimmed == "." {
            return .dot
        }
        return .nonEmpty
    }

    public var isConsideredEmpty: Bool {
        switch emptyState {
        case .empty, .dot, .whitespace: return true
        case .nonEmpty: return false
        }
    }
}

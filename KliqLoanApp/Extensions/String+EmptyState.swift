//
//  String+EmptyState.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

extension String {

    /// Label vb. parametrelerde `label: .empty` yazabilmek için.
    public static var empty: String { "" }

    /// Boşluk, "." veya gerçekten boş gibi "anlamsız" durumları temsil eder.
    public enum EmptyState {
        /// Tamamen boş: ""
        case empty
        /// Sadece nokta: "."
        case dot
        /// Sadece boşluk/newline: "   ", "\n"
        case whitespace
        /// Anlamlı içerik var
        case nonEmpty
    }

    /// Trim edilmiş metin boş mu, sadece "." mı yoksa sadece boşluk mu kontrol eder.
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

    /// `emptyState` .empty, .dot veya .whitespace ise true.
    public var isConsideredEmpty: Bool {
        switch emptyState {
        case .empty, .dot, .whitespace: return true
        case .nonEmpty: return false
        }
    }
}

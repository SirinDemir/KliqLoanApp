//
//  ModelTransferable.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

/// Veri transferi sırasında kullanılacak modellerin protokolü.
public protocol ModelTransferable {
    func describe() -> String
}

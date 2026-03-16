//
//  LoanProcessingStrategy.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol LoanProcessingStrategy {
    var loanType: String { get }
    func adjustInterestRate(loan: inout Loan) -> Double
    func updateStatus(loan: inout Loan)
}

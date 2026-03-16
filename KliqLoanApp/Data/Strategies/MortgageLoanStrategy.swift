//
//  MortgageLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct MortgageLoanStrategy: LoanProcessingStrategy {
    public let loanType = "mortgage"
    
    public init() {}
    
    public func adjustInterestRate(loan: inout Loan) -> Double {
        if loan.status == "active" {
            return loan.due_in > 0 ? 0.1 : 0.4
        } else if loan.status == "overdue" {
            return 0.8
        }
        return 0
    }
    
    public func updateStatus(loan: inout Loan) {
        if loan.status == "active" && loan.due_in <= 0 {
            loan.status = "overdue"
        } else if loan.status == "overdue" && loan.due_in < -60 {
            loan.status = "default"
        }
    }
}

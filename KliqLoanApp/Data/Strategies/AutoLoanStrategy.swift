//
//  AutoLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct AutoLoanStrategy: LoanProcessingStrategy {
    public let loanType = "auto"
    
    public init() {}
    
    public func adjustInterestRate(loan: inout Loan) -> Double {
        if loan.status == "active" {
            return loan.due_in > 0 ? 0.4 : 0.9
        } else if loan.status == "overdue" {
            return 1.8
        }
        return 0
    }
    
    public func updateStatus(loan: inout Loan) {
        if loan.status == "active" && loan.due_in <= 0 {
            loan.status = "overdue"
        } else if loan.status == "overdue" && loan.principal_amount > 50000 {
            loan.status = "default"
        }
    }
}

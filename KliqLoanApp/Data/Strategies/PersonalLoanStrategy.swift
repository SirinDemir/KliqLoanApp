//
//  PersonalLoanStrategy.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct PersonalLoanStrategy: LoanProcessingStrategy {
    public let loanType = "personal"
    
    public init() {}
    
    public func adjustInterestRate(loan: inout Loan) -> Double {
        if loan.status == "active" {
            if loan.due_in > 0 {
                return 0.3
            } else {
                return loan.principal_amount > 10000 ? 1.2 : 0.6
            }
        } else if loan.status == "overdue" {
            return 1.5
        }
        return 0
    }
    
    public func updateStatus(loan: inout Loan) {
        if loan.status == "active" && loan.due_in <= 0 {
            if loan.principal_amount > 10000 {
                loan.status = "overdue"
            }
        } else if loan.status == "overdue" && loan.principal_amount > 20000 {
            loan.status = "default"
        }
    }
}

//
//  LoanServiceProtocol.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol LoanServiceProtocol {
    func fetchLoans() async throws -> [Loan]
    func persistLoans(_ loans: [Loan]) async throws
}

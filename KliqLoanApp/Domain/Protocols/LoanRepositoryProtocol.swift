//
//  LoanRepositoryProtocol.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol LoanRepositoryProtocol {
    func processAndUpdateLoans() async throws -> [Loan]
}

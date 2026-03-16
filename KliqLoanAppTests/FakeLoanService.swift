//
//  FakeLoanService.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation
@testable import KliqLoanApp

final class FakeLoanService: LoanServiceProtocol {
    var loansToReturn: [Loan] = []
    var persistCalled = false
    
    func fetchLoans() async throws -> [Loan] {
        loansToReturn
    }
    
    func persistLoans(_ loans: [Loan]) async throws {
        persistCalled = true
    }
}

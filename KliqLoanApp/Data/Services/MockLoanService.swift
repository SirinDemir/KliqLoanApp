//
//  MockLoanService.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class MockLoanService: LoanServiceProtocol {
    public init() {}
    
    public func fetchLoans() async throws -> [Loan] {
        guard let url = Bundle.main.url(forResource: "loans", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw NSError(domain: "LoanServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load loan data"])
        }
        return try JSONDecoder().decode([Loan].self, from: data)
    }
    
    public func persistLoans(_ loans: [Loan]) async throws {}
}

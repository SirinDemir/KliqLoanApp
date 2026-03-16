//
//  LoanRepository.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class LoanRepository: LoanRepositoryProtocol {
    private let service: LoanServiceProtocol
    private let strategyFactory: LoanProcessingStrategyFactory
    
    public init(service: LoanServiceProtocol, strategyFactory: LoanProcessingStrategyFactory = LoanProcessingStrategyFactory()) {
        self.service = service
        self.strategyFactory = strategyFactory
    }
    
    public func processAndUpdateLoans() async throws -> [Loan] {
        var loans = try await service.fetchLoans()
        
        for i in 0..<loans.count {
            guard let strategy = strategyFactory.strategy(for: loans[i].type) else { continue }
            
            let adjustment = strategy.adjustInterestRate(loan: &loans[i])
            loans[i].interest_rate += adjustment
            strategy.updateStatus(loan: &loans[i])
            
            loans[i].due_in -= 1
            
            if loans[i].due_in < -90 && loans[i].status != "paid" {
                loans[i].status = "default"
            }
            
            if loans[i].principal_amount <= 0 {
                loans[i].status = "paid"
            }
        }
        
        try await service.persistLoans(loans)
        return loans
    }
}

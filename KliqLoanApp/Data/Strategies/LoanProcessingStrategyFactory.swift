//
//  LoanProcessingStrategyFactory.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class LoanProcessingStrategyFactory {
    private var strategies: [String: LoanProcessingStrategy] = [:]
    
    public init() {
        register(PersonalLoanStrategy())
        register(MortgageLoanStrategy())
        register(AutoLoanStrategy())
        register(BusinessLoanStrategy())
    }
    
    public func register(_ strategy: LoanProcessingStrategy) {
        strategies[strategy.loanType] = strategy
    }
    
    public func strategy(for type: String) -> LoanProcessingStrategy? {
        strategies[type]
    }
}

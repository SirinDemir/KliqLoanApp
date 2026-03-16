//
//  LoanProcessingStrategyTests.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import XCTest
@testable import KliqLoanApp

final class LoanProcessingStrategyTests: XCTestCase {
    
    func testPersonalLoanStrategy_Active_DueInPositive() {
        var loan = Loan(name: "Test", principal_amount: 5000, interest_rate: 5.0, status: "active", due_in: 30, type: "personal")
        let strategy = PersonalLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 0.3)
        XCTAssertEqual(loan.interest_rate, 5.3)
        XCTAssertEqual(loan.status, "active")
    }
    
    func testPersonalLoanStrategy_Active_DueInZero_PrincipalOver10k() {
        var loan = Loan(name: "Test", principal_amount: 15000, interest_rate: 5.0, status: "active", due_in: 0, type: "personal")
        let strategy = PersonalLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 1.2)
        XCTAssertEqual(loan.interest_rate, 6.2)
        XCTAssertEqual(loan.status, "overdue")
    }
    
    func testPersonalLoanStrategy_Overdue_PrincipalOver20k() {
        var loan = Loan(name: "Test", principal_amount: 25000, interest_rate: 5.0, status: "overdue", due_in: -5, type: "personal")
        let strategy = PersonalLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 1.5)
        XCTAssertEqual(loan.status, "default")
    }
    
    func testMortgageLoanStrategy_Active_DueInPositive() {
        var loan = Loan(name: "Test", principal_amount: 200000, interest_rate: 2.0, status: "active", due_in: 365, type: "mortgage")
        let strategy = MortgageLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 0.1)
        XCTAssertEqual(loan.interest_rate, 2.1)
        XCTAssertEqual(loan.status, "active")
    }
    
    func testMortgageLoanStrategy_Active_DueInZero() {
        var loan = Loan(name: "Test", principal_amount: 200000, interest_rate: 2.0, status: "active", due_in: 0, type: "mortgage")
        let strategy = MortgageLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 0.4)
        XCTAssertEqual(loan.status, "overdue")
    }
    
    func testAutoLoanStrategy_Overdue_PrincipalOver50k() {
        var loan = Loan(name: "Test", principal_amount: 60000, interest_rate: 4.0, status: "overdue", due_in: -10, type: "auto")
        let strategy = AutoLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 1.8)
        XCTAssertEqual(loan.status, "default")
    }
    
    func testBusinessLoanStrategy_Active_DueInPositive() {
        var loan = Loan(name: "Test", principal_amount: 100000, interest_rate: 4.0, status: "active", due_in: 180, type: "business")
        let strategy = BusinessLoanStrategy()
        
        let adjustment = strategy.adjustInterestRate(loan: &loan)
        loan.interest_rate += adjustment
        strategy.updateStatus(loan: &loan)
        
        XCTAssertEqual(adjustment, 0.5)
        XCTAssertEqual(loan.interest_rate, 4.5)
    }
    
    func testStrategyFactory_ReturnsCorrectStrategy() {
        let factory = LoanProcessingStrategyFactory()
        
        XCTAssertNotNil(factory.strategy(for: "personal"))
        XCTAssertNotNil(factory.strategy(for: "mortgage"))
        XCTAssertNotNil(factory.strategy(for: "auto"))
        XCTAssertNotNil(factory.strategy(for: "business"))
        XCTAssertNil(factory.strategy(for: "unknown"))
    }
}

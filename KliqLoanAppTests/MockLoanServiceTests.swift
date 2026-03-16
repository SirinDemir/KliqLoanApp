//
//  MockLoanServiceTests.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import XCTest
@testable import KliqLoanApp

@MainActor
final class MockLoanServiceTests: XCTestCase {
    
    func testLoanRepository_ProcessLoans_WithStrategy() async throws {
        let service = FakeLoanService()
        service.loansToReturn = [
            Loan(name: "Test Personal", principal_amount: 5000, interest_rate: 5.0, status: "active", due_in: 30, type: "personal"),
            Loan(name: "Test Mortgage", principal_amount: 200000, interest_rate: 2.0, status: "active", due_in: 365, type: "mortgage")
        ]
        let repository = LoanRepository(service: service)
        
        let loans = try await repository.processAndUpdateLoans()
        
        XCTAssertEqual(loans.count, 2)
        XCTAssertTrue(service.persistCalled)
        XCTAssertEqual(loans[0].interest_rate, 5.3)
        XCTAssertEqual(loans[0].due_in, 29)
    }
    
    func testHomeViewModel_Filtering() async {
        let service = FakeLoanService()
        service.loansToReturn = [
            Loan(name: "Active 1", principal_amount: 1000, interest_rate: 5.0, status: "active", due_in: 10, type: "personal"),
            Loan(name: "Overdue 1", principal_amount: 2000, interest_rate: 5.0, status: "overdue", due_in: -5, type: "personal")
        ]
        let repository = LoanRepository(service: service)
        let loanReactive = LoanReactive(repository: repository)
        let sessionStorage = SessionStorage()
        let authService = MockAuthService(sessionStorage: sessionStorage)
        let router = Router(authService: authService)
        let viewModel = HomeViewModel(loanReactive: loanReactive, router: router)
        
        viewModel.loadLoans()
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        XCTAssertEqual(viewModel.allLoans.count, 2)
        
        viewModel.selectFilter(.active)
        XCTAssertEqual(viewModel.filteredLoans.count, 1)
        XCTAssertEqual(viewModel.filteredLoans[0].status, "active")
        
        viewModel.selectFilter(.overdue)
        XCTAssertEqual(viewModel.filteredLoans.count, 1)
        XCTAssertEqual(viewModel.filteredLoans[0].status, "overdue")
        
        viewModel.selectFilter(.all)
        XCTAssertEqual(viewModel.filteredLoans.count, 2)
    }
}

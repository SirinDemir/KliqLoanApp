//
//  LoginViewModelTests.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import XCTest
@testable import KliqLoanApp

@MainActor
final class LoginViewModelTests: XCTestCase {
    
    func testValidateForm_EmptyEmail() {
        let sessionStorage = SessionStorage()
        let authService = MockAuthService(sessionStorage: sessionStorage)
        let authReactive = AuthReactive(authService: authService)
        let router = Router(authService: authService)
        let viewModel = LoginViewModel(authReactive: authReactive, router: router)

        viewModel.updateValidation(email: "", password: "password123")

        XCTAssertFalse(viewModel.emailValidation?.isValid ?? true)
    }

    func testValidateForm_InvalidEmail() {
        let sessionStorage = SessionStorage()
        let authService = MockAuthService(sessionStorage: sessionStorage)
        let authReactive = AuthReactive(authService: authService)
        let router = Router(authService: authService)
        let viewModel = LoginViewModel(authReactive: authReactive, router: router)

        viewModel.updateValidation(email: "notanemail", password: "password123")

        XCTAssertFalse(viewModel.emailValidation?.isValid ?? true)
    }

    func testValidateForm_ShortPassword() {
        let sessionStorage = SessionStorage()
        let authService = MockAuthService(sessionStorage: sessionStorage)
        let authReactive = AuthReactive(authService: authService)
        let router = Router(authService: authService)
        let viewModel = LoginViewModel(authReactive: authReactive, router: router)

        viewModel.updateValidation(email: "user@example.com", password: "12345")

        XCTAssertFalse(viewModel.passwordValidation?.isValid ?? true)
    }

    func testValidateForm_ValidInput() {
        let sessionStorage = SessionStorage()
        let authService = MockAuthService(sessionStorage: sessionStorage)
        let authReactive = AuthReactive(authService: authService)
        let router = Router(authService: authService)
        let viewModel = LoginViewModel(authReactive: authReactive, router: router)

        viewModel.updateValidation(email: "user@example.com", password: "password123")

        XCTAssertTrue(viewModel.emailValidation?.isValid ?? false)
        XCTAssertTrue(viewModel.passwordValidation?.isValid ?? false)
    }
}

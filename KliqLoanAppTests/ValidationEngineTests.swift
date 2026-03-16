//
//  ValidationEngineTests.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import XCTest
@testable import KliqLoanApp

final class ValidationProviderTests: XCTestCase {
    
    func testEmailValidationProvider_ValidEmail() {
        let provider = EmailValidationProvider()
        let result = provider.validate("user@example.com")
        XCTAssertTrue(result.isValid)
    }
    
    func testEmailValidationProvider_InvalidEmail() {
        let provider = EmailValidationProvider()
        let result = provider.validate("invalid-email")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Invalid email format")
    }
    
    func testEmailValidationProvider_Empty() {
        let provider = EmailValidationProvider()
        let result = provider.validate("")
        XCTAssertFalse(result.isValid)
    }
    
    func testRequiredValidationProvider_Empty() {
        let provider = RequiredValidationProvider(fieldName: "Email")
        let result = provider.validate("")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Email is required")
    }
    
    func testRequiredValidationProvider_WhitespaceOnly() {
        let provider = RequiredValidationProvider(fieldName: "Field")
        let result = provider.validate("   ")
        XCTAssertFalse(result.isValid)
    }
    
    func testRequiredValidationProvider_Valid() {
        let provider = RequiredValidationProvider(fieldName: "Field")
        let result = provider.validate("value")
        XCTAssertTrue(result.isValid)
    }
    
    func testEmptyValidationProvider_Empty() {
        let provider = EmptyValidationProvider()
        let result = provider.validate("")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Input is empty")
    }
    
    func testMinLengthValidationProvider_TooShort() {
        let provider = MinLengthValidationProvider(minLength: 6, fieldName: "Password")
        let result = provider.validate("12345")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Password must be at least 6 characters")
    }
    
    func testMinLengthValidationProvider_Valid() {
        let provider = MinLengthValidationProvider(minLength: 6, fieldName: "Password")
        let result = provider.validate("123456")
        XCTAssertTrue(result.isValid)
    }
    
    func testCountValidationProvider_ValidRange() {
        let provider = CountValidationProvider(minLength: 5, maxLength: 12)
        let result = provider.validate("123456")
        XCTAssertTrue(result.isValid)
    }
    
    func testCompositeValidationProvider_AllPass() {
        let provider = CompositeValidationProvider(providers: [
            RequiredValidationProvider(fieldName: "Email"),
            EmailValidationProvider()
        ])
        let result = provider.validate("test@test.com")
        XCTAssertTrue(result.isValid)
    }
    
    func testCompositeValidationProvider_FirstFails() {
        let provider = CompositeValidationProvider(providers: [
            RequiredValidationProvider(fieldName: "Email"),
            EmailValidationProvider()
        ])
        let result = provider.validate("")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Email is required")
    }
    
    func testCompositeValidationProvider_SecondFails() {
        let provider = CompositeValidationProvider(providers: [
            RequiredValidationProvider(fieldName: "Email"),
            EmailValidationProvider()
        ])
        let result = provider.validate("invalid")
        XCTAssertFalse(result.isValid)
        XCTAssertEqual(result.errorMessage, "Invalid email format")
    }
    
    func testValidationResult_ValidateRegex() {
        let result = ValidationResult.validateRegex("test@test.com", regex: #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#)
        XCTAssertTrue(result.isValid)
        
        let failResult = ValidationResult.validateRegex(nil, regex: ".*")
        XCTAssertFalse(failResult.isValid)
        XCTAssertEqual(failResult.errorMessage, "Input is nil")
    }
}

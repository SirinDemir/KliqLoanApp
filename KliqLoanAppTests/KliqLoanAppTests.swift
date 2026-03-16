//
//  KliqLoanAppTests.swift
//  KliqLoanAppTests
//
//  Created by Sirin Demir on 15.03.2025.
//

import XCTest
@testable import KliqLoanApp

final class KliqLoanAppTests: XCTestCase {

    func testSessionStorage_PropertyWrapper() {
        let storage = SessionStorage()
        
        XCTAssertFalse(storage.isLoggedIn)
        storage.setLoggedIn(true)
        XCTAssertTrue(storage.isLoggedIn)
        storage.setLoggedIn(false)
        XCTAssertFalse(storage.isLoggedIn)
    }
}

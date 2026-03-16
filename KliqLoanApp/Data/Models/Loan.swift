//
//  Loan.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public struct Loan: Codable, Identifiable, Equatable {
    public var id: String { "\(name)-\(principal_amount)-\(type)" }
    public var name: String
    public var principal_amount: Double
    public var interest_rate: Double
    public var status: String
    public var due_in: Int
    public var type: String
    
    public init(name: String, principal_amount: Double, interest_rate: Double, status: String, due_in: Int, type: String) {
        self.name = name
        self.principal_amount = principal_amount
        self.interest_rate = interest_rate
        self.status = status
        self.due_in = due_in
        self.type = type
    }
}

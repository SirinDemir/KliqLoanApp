//
//  LoanReactive.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation
import Combine

public protocol LoanReactiveProtocol {
    /// Kredi listesini Observable (Publisher) olarak döner; flatMap ile tetiklenebilir.
    func processAndUpdateLoans() -> AnyPublisher<[Loan], Error>
}

public final class LoanReactive: LoanReactiveProtocol {
    private let repository: LoanRepositoryProtocol

    public init(repository: LoanRepositoryProtocol) {
        self.repository = repository
    }

    public func processAndUpdateLoans() -> AnyPublisher<[Loan], Error> {
        Deferred {
            Future<[Loan], Error> { [weak self] promise in
                guard let self else { return }
                Task {
                    do {
                        let loans = try await self.repository.processAndUpdateLoans()
                        promise(.success(loans))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

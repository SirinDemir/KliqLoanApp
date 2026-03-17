//
//  AuthReactive.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation
import Combine

public protocol AuthReactiveProtocol {
    
    func login(email: String, password: String) -> AnyPublisher<Bool, Error>
    func logout() -> AnyPublisher<Void, Never>
    var isLoggedIn: Bool { get }
}

public final class AuthReactive: AuthReactiveProtocol {
    private let authService: AuthServiceProtocol

    public init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    public var isLoggedIn: Bool {
        authService.isLoggedIn
    }

    public func login(email: String, password: String) -> AnyPublisher<Bool, Error> {
        Deferred {
            Future<Bool, Error> { [weak self] promise in
                guard let self else { return }
                Task {
                    do {
                        let success = try await self.authService.login(email: email, password: password)
                        promise(.success(success))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    public func logout() -> AnyPublisher<Void, Never> {
        Deferred {
            Future<Void, Never> { [weak self] promise in
                guard let self else { return }
                Task {
                    await self.authService.logout()
                    promise(.success(()))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

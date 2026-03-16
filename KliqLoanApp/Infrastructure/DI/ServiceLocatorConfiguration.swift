//
//  ServiceLocatorConfiguration.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public enum ServiceLocatorConfiguration {
    
    public static func configure() {
        KeychainManager.configure(with: KeychainManagerConfig(serviceIdentifier: Bundle.main.bundleIdentifier))

        let locator = ServiceLocator.shared

        let sessionStorage = SessionStorage()
        sessionStorage.clearSession()
        locator.register(sessionStorage, as: SessionStorageProtocol.self)

        let authService = MockAuthService(sessionStorage: sessionStorage)
        locator.register(authService, as: AuthServiceProtocol.self)
        
        let authReactive = AuthReactive(authService: authService)
        locator.register(authReactive, as: AuthReactiveProtocol.self)
        
        let loanService = MockLoanService()
        locator.register(loanService, as: LoanServiceProtocol.self)
        
        let strategyFactory = LoanProcessingStrategyFactory()
        locator.register(strategyFactory)
        
        let loanRepository = LoanRepository(service: loanService, strategyFactory: strategyFactory)
        locator.register(loanRepository, as: LoanRepositoryProtocol.self)
        
        let loanReactive = LoanReactive(repository: loanRepository)
        locator.register(loanReactive, as: LoanReactiveProtocol.self)
        
        let router = Router(authService: authService)
        locator.register(router)
    }
}

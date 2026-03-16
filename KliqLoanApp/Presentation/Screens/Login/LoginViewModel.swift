//
//  LoginViewModel.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI
import Combine

@MainActor
public final class LoginViewModel: BaseViewModel, ValidationHandler {
    /// Sadece validasyon sonuçları tutulur; email/password ViewModel'de hiç tutulmaz (callback ile gelir).
    @Published public var emailValidation: ValidationResult?
    @Published public var passwordValidation: ValidationResult?

    private let authReactive: AuthReactiveProtocol?
    private let router: Router?
    private let emailProvider: ValidationProvider
    private let passwordProvider: ValidationProvider
    private var cancellables = Set<AnyCancellable>()

    private let loginTrigger = PassthroughSubject<(email: String, password: String), Never>()

    public init(
        authReactive: AuthReactiveProtocol? = nil,
        router: Router? = nil,
        emailProvider: ValidationProvider = CompositeValidationProvider(providers: [
            RequiredValidationProvider(fieldName: Keys.Validation.email),
            EmailValidationProvider()
        ]),
        passwordProvider: ValidationProvider = CompositeValidationProvider(providers: [
            RequiredValidationProvider(fieldName: Keys.Validation.password),
            MinLengthValidationProvider(minLength: 6)
        ])
    ) {
        let ar = authReactive ?? ServiceLocator.shared.resolve(AuthReactiveProtocol.self)
        let r = router ?? ServiceLocator.shared.resolve(Router.self)
        self.authReactive = ar
        self.router = r
        self.emailProvider = emailProvider
        self.passwordProvider = passwordProvider
        super.init()
        if ar == nil || r == nil {
            configurationError = Keys.Common.configurationError
        } else {
            bindLoginObserver()
        }
    }

    private func bindLoginObserver() {
        guard let authReactive, let router else { return }
        loginTrigger
            .flatMap { [weak self] credentials -> AnyPublisher<(Bool, String), Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                self.setLoadingState(.loading)
                self.dismissError()
                return authReactive.login(email: credentials.email, password: credentials.password)
                    .map { ($0, credentials.email) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.setLoadingState(.idle)
                    if case .failure(let error) = completion {
                        self?.showError(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] success, email in
                    self?.setLoadingState(.success)
                    if success {
                        router.navigateToHome(withTransferedData: UserTransferData(email: email))
                    }
                    self?.setLoadingState(.idle)
                }
            )
            .store(in: &cancellables)
    }

    /// View'dan onChange callback ile çağrılır; sadece validasyon sonuçları güncellenir, credential saklanmaz.
    public func updateValidation(email: String, password: String) {
        emailValidation = emailProvider.validate(email)
        passwordValidation = passwordProvider.validate(password)
    }

    /// View'dan Sign In tıklanınca çağrılır; credential'lar sadece parametre olarak gelir, ViewModel'de tutulmaz.
    public func signIn(email: String, password: String) {
        guard authReactive != nil, router != nil else {
            showError(configurationError ?? Keys.Common.configurationError)
            return
        }
        let emailResult = emailProvider.validate(email)
        let passwordResult = passwordProvider.validate(password)
        emailValidation = emailResult
        passwordValidation = passwordResult
        guard emailResult.isValid, passwordResult.isValid else { return }
        loginTrigger.send((email: email, password: password))
    }
}

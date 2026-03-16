//
//  Router.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public final class Router: ObservableObject {
    @Published private(set) public var currentRoute: AppRoute

    public var isLoggedIn: Bool {
        currentRoute == .home
    }

    private let authService: AuthServiceProtocol

    /// Navigasyonda hedef ekrana aktarılacak veri (makale: withTransferedData).
    private(set) public var pendingTransferData: ModelTransferable?
    /// Hedef ekrandan veri dönüşü için callback (makale: withDataHandler).
    private var pendingCompletionHandler: CompletionDataHandler?

    public init(authService: AuthServiceProtocol) {
        self.authService = authService
        self.currentRoute = authService.isLoggedIn ? .home : .login
    }

    // MARK: - Presentation Style (makale)

    public enum PresentationStyle {
        case push
        case present
        case presentWithNavigation
    }

    // MARK: - Navigation (makale: navigate)

    /// Home ekranına geçiş - veri transferi ve callback desteği.
    public func navigateToHome(
        withTransferedData data: ModelTransferable? = nil,
        withDataHandler dataHandler: CompletionDataHandler? = nil,
        completion: (() -> Void)? = nil
    ) {
        pendingTransferData = data
        pendingCompletionHandler = dataHandler
        currentRoute = .home
        completion?()
    }

    /// Eski API uyumluluğu.
    public func navigateToHome() {
        navigateToHome(withTransferedData: nil, withDataHandler: nil, completion: nil)
    }

    /// Hedef ekrana aktarılan veriyi tüketir (DataReturnable için).
    public func consumePendingTransferData() -> ModelTransferable? {
        defer { pendingTransferData = nil }
        return pendingTransferData
    }

    /// Tamamlanınca veri döndürmek için handler'ı alır.
    public func consumePendingCompletionHandler() -> CompletionDataHandler? {
        defer { pendingCompletionHandler = nil }
        return pendingCompletionHandler
    }

    /// Hedef ekrandan veri döndürür (CompletionHandling - makale).
    public func returnData(_ data: ModelTransferable) {
        pendingCompletionHandler?(data)
        pendingCompletionHandler = nil
    }

    public func logout() {
        pendingTransferData = nil
        pendingCompletionHandler = nil
        Task {
            await authService.logout()
            await MainActor.run {
                currentRoute = .login
            }
        }
    }

    public func refreshAuthState() {
        currentRoute = authService.isLoggedIn ? .home : .login
    }
}

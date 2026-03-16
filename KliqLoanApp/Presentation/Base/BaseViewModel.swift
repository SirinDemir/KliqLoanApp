//
//  BaseViewModel.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI
import Combine

/// İstek atıldığında tetiklenir; success veya bitişte deactive olur.
public enum LoadingState {
    case idle
    case loading
    case success
}

@MainActor
open class BaseViewModel: ObservableObject {
    @Published public var loadingState: LoadingState = .idle
    @Published public var errorMessage: String?
    @Published public var showErrorAlert = false
    /// DI yapılandırma hatası (fatalError yerine kullanıcıya gösterilir).
    @Published public var configurationError: String?

    /// Geriye uyumluluk ve overlay/disabled için (loadingState == .loading).
    public var isLoading: Bool {
        loadingState == .loading
    }

    public init() {}

    public func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
        GlobalErrorDisplay.shared.showError(message)
    }

    public func dismissError() {
        errorMessage = nil
        showErrorAlert = false
    }

    /// İstek başladığında tetikle.
    public func setLoading(_ loading: Bool) {
        loadingState = loading ? .loading : .idle
    }

    /// Enum ile doğrudan set (isteğe göre success sonrası kısa süre .success tutulabilir).
    public func setLoadingState(_ state: LoadingState) {
        loadingState = state
    }
}

// MARK: - Tüm ekranlarda kullanılacak hata alert'i

extension View {
    /// BaseViewModel error state ile aynı alert'i gösterir; tüm ekranlarda tek tip hata dialog'u için.
    public func baseErrorAlert(
        isPresented: Binding<Bool>,
        message: String?,
        onDismiss: @escaping () -> Void
    ) -> some View {
        alert(Keys.Common.error, isPresented: isPresented) {
            Button(Keys.Common.ok, action: onDismiss)
        } message: {
            if let message, !message.isEmpty {
                Text(message)
            }
        }
    }
}

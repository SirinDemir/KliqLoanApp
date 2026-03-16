//
//  KliqLoanApp.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

@main
struct KliqLoanApp: App {
    @StateObject private var router: Router
    @StateObject private var windowEvents = WindowEventSystem.shared
    
    init() {
        ServiceLocatorConfiguration.configure()
        let router = ServiceLocator.shared.resolve(Router.self)!
        _router = StateObject(wrappedValue: router)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(router: router)
                .onReceive(windowEvents.eventPublisher) { event in
                    if event == .didBecomeActive || event == .willEnterForeground {
                        router.refreshAuthState()
                    }
                }
        }
    }
}

struct RootView: View {
    @ObservedObject var router: Router
    @ObservedObject private var globalError = GlobalErrorDisplay.shared

    @State private var loginViewModel: LoginViewModel?
    @State private var homeViewModel: HomeViewModel?

    var body: some View {
        Group {
            if router.isLoggedIn {
                NavigationStack {
                    if let vm = homeViewModel {
                        HomeView(viewModel: vm)
                    } else {
                        ProgressView()
                            .onAppear { homeViewModel = makeHomeViewModel() }
                    }
                }
            } else {
                NavigationStack {
                    if let vm = loginViewModel {
                        LoginView(viewModel: vm)
                    } else {
                        ProgressView()
                            .onAppear { loginViewModel = makeLoginViewModel() }
                    }
                }
            }
        }
        .baseErrorAlert(
            isPresented: Binding(
                get: { globalError.showErrorAlert },
                set: { if !$0 { globalError.dismissError() } }
            ),
            message: globalError.errorMessage,
            onDismiss: globalError.dismissError
        )
        .onAppear {
            router.refreshAuthState()
        }
        .onChange(of: router.isLoggedIn) { _, isLoggedIn in
            if !isLoggedIn { homeViewModel = nil }
        }
    }

    private func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel()
    }

    private func makeHomeViewModel() -> HomeViewModel {
        let vm = HomeViewModel()
        if let data = router.consumePendingTransferData() {
            vm.prepareInjectData(data)
        }
        if let handler = router.consumePendingCompletionHandler() {
            vm.setCompletionDataHandler(handler)
        }
        return vm
    }
}

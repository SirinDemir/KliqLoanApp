//
//  LoginView.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @FocusState private var focusedField: FormFieldType?

    @State private var email = ""
    @State private var password = ""

    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Group {
            if let configError = viewModel.configurationError {
                configErrorView(message: configError)
            } else {
                loginContent
            }
        }
        .navigationTitle(Keys.Login.title)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: focusedField) { _, newValue in
            if newValue == nil {
                viewModel.updateValidation(email: email, password: password)
                viewModel.setLoadingState(.idle)
            }
        }
        .onDisappear {
            viewModel.setLoadingState(.idle)
        }
    }

    private func configErrorView(message: String) -> some View {
        VStack(spacing: Spacing.large.rawValue) {
            StyledText(message, provider: ErrorTextStyleProvider())
                .multilineTextAlignment(.center)
                .padding(Spacing.xLarge)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorProvider.background)
    }

    private var loginContent: some View {
        ScrollView {
            VStack(spacing: 14) {
                Image("kliq_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)

                FormField(
                    label: .empty,
                    placeholder: Keys.Login.placeholderEmail,
                    text: $email,
                    validationResult: viewModel.emailValidation,
                    fieldType: FormFieldType.email,
                    focusBinding: $focusedField,
                    onNext: { focusedField = .password }
                )

                FormField(
                    label: .empty,
                    placeholder: Keys.Login.placeholderPassword,
                    text: $password,
                    validationResult: viewModel.passwordValidation,
                    fieldType: FormFieldType.password,
                    isSecure: true,
                    focusBinding: $focusedField,
                    onSubmit: { submitLogin() }
                )

                if let error = viewModel.errorMessage {
                    StyledText(error, provider: ErrorTextStyleProvider())
                        .multilineTextAlignment(.center)
                }

                ConfigurableButton(config: ButtonConfig(
                    title: Keys.Login.signIn,
                    isLoading: viewModel.isLoading,
                    action: { submitLogin() }
                ))
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(ColorProvider.background)
        .overlay {
            if viewModel.isLoading {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
            }
        }
        .allowsHitTesting(!viewModel.isLoading)
    }

    private func submitLogin() {
        viewModel.signIn(email: email, password: password)
        password = ""
    }
}

//
//  GlobalErrorDisplay.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI
import Combine

@MainActor
public final class GlobalErrorDisplay: ObservableObject {
    public static let shared = GlobalErrorDisplay()

    @Published public private(set) var errorMessage: String?
    @Published public var showErrorAlert = false

    private init() {}

    public func showError(_ message: String) {
        errorMessage = message.isEmpty ? nil : message
        showErrorAlert = true
    }

    public func dismissError() {
        errorMessage = nil
        showErrorAlert = false
    }
}

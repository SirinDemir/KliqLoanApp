//
//  ButtonConfig.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

public struct ButtonConfig {
    public let title: String
    public let backgroundColor: Color
    public let foregroundColor: Color
    public let action: () -> Void
    public var isLoading: Bool
    public var isDisabled: Bool
    
    public init(
        title: String,
        backgroundColor: Color = ColorProvider.primary,
        foregroundColor: Color = ColorProvider.textOnPrimary,
        isLoading: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }
}

public struct ConfigurableButton: View {
    let config: ButtonConfig
    
    public init(config: ButtonConfig) {
        self.config = config
    }
    
    public var body: some View {
        Button(action: config.action) {
            HStack(spacing: 8) {
                if config.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: config.foregroundColor))
                } else {
                    Text(config.title)
                        .font(FontProvider.bodyBold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(config.backgroundColor)
            .foregroundColor(config.foregroundColor)
            .cornerRadius(10)
        }
        .disabled(config.isLoading || config.isDisabled)
    }
}

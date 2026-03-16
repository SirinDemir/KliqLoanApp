//
//  StyledText.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

/// TextStyleProvider ile stil uygulanmış metin görünümü (makale: BaseLabel).
public struct StyledText<Provider: TextStyleProvider>: View {
    private let text: String
    private let provider: Provider

    public init(_ text: String, provider: Provider) {
        self.text = text
        self.provider = provider
    }

    public var body: some View {
        Text(text)
            .font(provider.font)
            .foregroundColor(provider.foregroundColor)
    }
}

// MARK: - Convenience subclasses (makale: SmallLabel, MediumLabel, LargeLabel)

public struct SmallStyledText: View {
    private let text: String
    private let provider: SmallTextStyleProvider

    public init(_ text: String, provider: SmallTextStyleProvider = SmallTextStyleProvider()) {
        self.text = text
        self.provider = provider
    }

    public var body: some View {
        StyledText(text, provider: provider)
    }
}

public struct MediumStyledText: View {
    private let text: String
    private let provider: MediumTextStyleProvider

    public init(_ text: String, provider: MediumTextStyleProvider = MediumTextStyleProvider()) {
        self.text = text
        self.provider = provider
    }

    public var body: some View {
        StyledText(text, provider: provider)
    }
}

public struct LargeStyledText: View {
    private let text: String
    private let provider: LargeTextStyleProvider

    public init(_ text: String, provider: LargeTextStyleProvider = LargeTextStyleProvider()) {
        self.text = text
        self.provider = provider
    }

    public var body: some View {
        StyledText(text, provider: provider)
    }
}

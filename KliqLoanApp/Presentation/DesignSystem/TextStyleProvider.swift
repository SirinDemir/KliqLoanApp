//
//  TextStyleProvider.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

/// Metin stilleri için sağlayıcı protokolü (makale: LabelStyleProvider).
public protocol TextStyleProvider {
    var font: Font { get }
    var foregroundColor: Color { get }
}

// MARK: - Small Style
public struct SmallTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.small }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Medium Style
public struct MediumTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.body }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Large Style
public struct LargeTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.heading }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Heading Style
public struct HeadingTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.heading }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Title Style
public struct TitleTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.title }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Body Style
public struct BodyTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.body }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Body Bold Style
public struct BodyBoldTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.bodyBold }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Caption Style
public struct CaptionTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.caption }
    public var foregroundColor: Color { ColorProvider.textSecondary }
    public init() {}
}

// MARK: - Caption On Primary Style
public struct CaptionOnPrimaryTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.caption }
    public var foregroundColor: Color { ColorProvider.textOnPrimaryMuted }
    public init() {}
}

// MARK: - Amount Style
public struct AmountTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.amount }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Error Style
public struct ErrorTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.error }
    public var foregroundColor: Color { ColorProvider.error }
    public init() {}
}

// MARK: - Badge Style (on colored background)
public struct BadgeTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.badge }
    public var foregroundColor: Color { ColorProvider.textOnPrimary }
    public init() {}
}

// MARK: - Form Label Style
public struct FormLabelTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.caption }
    public var foregroundColor: Color { ColorProvider.textPrimary }
    public init() {}
}

// MARK: - Heading On Primary (dark card)
public struct HeadingOnPrimaryTextStyleProvider: TextStyleProvider {
    public var font: Font { FontProvider.heading }
    public var foregroundColor: Color { ColorProvider.textOnPrimary }
    public init() {}
}

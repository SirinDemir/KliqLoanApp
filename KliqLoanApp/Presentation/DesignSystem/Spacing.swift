//
//  Spacing.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

/// Small = 4 olan spacing ölçeği.
public enum Spacing: CGFloat, CaseIterable {
    case small = 4
    case medium = 8
    case large = 12
    case xLarge = 16
    case xxLarge = 20
}

/// Köşe yuvarlama değerleri.
public enum CornerRadius: CGFloat, CaseIterable {
    case small = 8
    case medium = 12
    case large = 14
}

// MARK: - View extensions

extension View {

    public func padding(_ spacing: Spacing) -> some View {
        padding(spacing.rawValue)
    }

    public func padding(_ edges: Edge.Set, _ spacing: Spacing) -> some View {
        padding(edges, spacing.rawValue)
    }

    public func cornerRadius(_ radius: CornerRadius) -> some View {
        cornerRadius(radius.rawValue)
    }
}

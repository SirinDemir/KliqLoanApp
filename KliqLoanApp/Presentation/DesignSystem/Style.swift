//
//  Style.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI

/// Stil bilgisini closure ile tutar ve hedef nesneye uygular.
public struct Style<T> {
    public let apply: (T) -> Void

    public init(apply: @escaping (T) -> Void) {
        self.apply = apply
    }

    public func apply(to item: T) {
        apply(item)
    }
}

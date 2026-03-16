//
//  CompletionHandling.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public typealias CompletionDataHandler = (ModelTransferable) -> Void

/// Veri döndürecek ekranların implement ettiği protokol.
public protocol CompletionHandling: AnyObject {
    func setCompletionDataHandler(_ handler: @escaping CompletionDataHandler)
}

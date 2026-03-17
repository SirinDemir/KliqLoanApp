//
//  CompletionHandling.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public typealias CompletionDataHandler = (ModelTransferable) -> Void

public protocol CompletionHandling: AnyObject {
    func setCompletionDataHandler(_ handler: @escaping CompletionDataHandler)
}

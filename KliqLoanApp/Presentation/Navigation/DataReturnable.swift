//
//  DataReturnable.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public protocol DataReturnable: AnyObject {
    func prepareInjectData(_ data: ModelTransferable?)
}

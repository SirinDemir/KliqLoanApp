//
//  Inject.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
    private var service: T?
    private var creator: (() -> T)?
    
    public init() {
        self.creator = nil
    }
    
    public init(creator: @escaping () -> T) {
        self.creator = creator
    }
    
    public var wrappedValue: T? {
        mutating get {
            if service == nil {
                if let creator = creator {
                    service = ServiceLocator.shared.resolveOrCreate(T.self, creator: creator)
                } else {
                    service = ServiceLocator.shared.resolve(T.self)
                }
            }
            return service
        }
        set {
            service = newValue
        }
    }
}

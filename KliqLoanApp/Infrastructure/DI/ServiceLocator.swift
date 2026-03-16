//
//  ServiceLocator.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import Foundation

public final class ServiceLocator {
    public static let shared = ServiceLocator()
    private var services: [ObjectIdentifier: Any] = [:]

    private init() {}

    /// Servisi Service Locator'a kaydeder. ObjectIdentifier ile tip çakışması önlenir.
    public func register<T>(_ service: T) {
        services[ObjectIdentifier(T.self)] = service
    }

    /// Servisi belirtilen tip için kaydeder (protokol çözümlemesi için).
    public func register<T>(_ service: T, as type: T.Type) {
        services[ObjectIdentifier(type)] = service
    }

    /// Service Locator'dan servisi çözümler.
    public func resolve<T>(_ type: T.Type) -> T? {
        services[ObjectIdentifier(type)] as? T
    }

    /// Servisi bulur; yoksa creator ile oluşturur, kaydeder ve döner.
    public func resolveOrCreate<T>(_ type: T.Type, creator: @escaping () -> T) -> T {
        if let service = resolve(type) {
            return service
        }
        let newService = creator()
        register(newService, as: type)
        return newService
    }
}

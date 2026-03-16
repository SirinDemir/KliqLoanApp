//
//  WindowEventSystem.swift
//  KliqLoanApp
//
//  Created by Sirin Demir on 15.03.2025.
//

import SwiftUI
import Combine
import UIKit

public enum AppWindowEvent {
    case didBecomeActive
    case willResignActive
    case willEnterForeground
    case didEnterBackground
}

public final class WindowEventSystem: ObservableObject {
    public static let shared = WindowEventSystem()
    
    @Published public private(set) var lastEvent: AppWindowEvent?
    
    private let notificationCenter = NotificationCenter.default
    private var cancellables = Set<AnyCancellable>()
    
    public let eventPublisher = PassthroughSubject<AppWindowEvent, Never>()
    
    private init() {
        setupObservers()
    }
    
    private func setupObservers() {
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.handleEvent(.didBecomeActive)
            }
            .store(in: &cancellables)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in
                self?.handleEvent(.willResignActive)
            }
            .store(in: &cancellables)
        
        notificationCenter.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.handleEvent(.willEnterForeground)
            }
            .store(in: &cancellables)
        
        notificationCenter.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.handleEvent(.didEnterBackground)
            }
            .store(in: &cancellables)
    }
    
    private func handleEvent(_ event: AppWindowEvent) {
        lastEvent = event
        eventPublisher.send(event)
    }
}

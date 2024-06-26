//
//  OnLoadComplete.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation
import os

extension LocalEvent {
    static let DIContainerReady = LocalEvent("DIContainerReady")
    static let SplashScreenComplete = LocalEvent("SplashScreenComplete")
    static let GamekitIntegrationReady = LocalEvent("GamekitIntegrationReady")
    static let SettingsConfigured = LocalEvent("SettingsConfigured")
}

/// The game is only ready when:
/// - Dependency injection container is ready
/// - Game settings are configured
/// - Gamekit integration is ready
/// - Splash screen is complete
///
/// If all conditions are met, the move the state of game to `LoadComplete`
class OnLoadComplete: ClassSeparatedEventListener {
    private static let requiredEvents: [LocalEvent] = [.DIContainerReady, .SplashScreenComplete, .GamekitIntegrationReady, .SettingsConfigured]
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: OnLoadComplete.self))
    
    private var loadCheckList = Set<LocalEvent>(requiredEvents)
    
    func getRegisteredEvents() -> [LocalEvent] {
        return Self.requiredEvents
    }
    
    func onEvent(event: LocalEvent, data: Any?, context: Any?) {
        guard Self.requiredEvents.contains(event) else {
            return
        }
        loadCheckList.remove(event)
        
        if loadCheckList.isEmpty, let systemState = context as? SystemState {
            systemState.state = .LoadComplete
        }
    }
}

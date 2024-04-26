//
//  ShowingAlert.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import Foundation
import os

extension LocalEvent {
    static let GamekitIntegrationFailed = LocalEvent("GamekitIntegrationFailed")
}

/// If there is an error in integrating Game Center, show an alert
class OnGameKitIntegrationFailed: ClassSeparatedEventListener {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: OnGameKitIntegrationFailed.self))
    
    func getRegisteredEvents() -> [LocalEvent] {
        return [.GamekitIntegrationFailed]
    }
    
    func onEvent(event: LocalEvent, data: Any?, context: Any?) {
        guard let systemState = context as? SystemState else {
            return
        }
        
        guard systemState.state < .LoadComplete else {
            return
        }
        
        systemState.currentAlert = AlertMetadata(
            title: "Game Center Integration Failed",
            message: "The game center integration has failed. Please try again later."
        )
    }
}

// Add here for more Alert handlers

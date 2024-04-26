//
//  InitHandlers.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation
import os

/// A wrapper for a class separated event listener. Each
/// class have their own logic to handle events.
protocol ClassSeparatedEventListener: EventListener {
    func getRegisteredEvents() -> [LocalEvent]
}

fileprivate let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: EventManager.self)
)

/// All events should be registered here
fileprivate let handlers: [ClassSeparatedEventListener] = [
    OnLoadComplete(),
    OnGameKitIntegrationFailed(),
    MoveFromLoadCompleted(),
]

func registerEventHandlers(eventManager: EventManager, context: AnyObject? = nil) {
    for handler in handlers {
        eventManager.registerListener(listener: handler, events: handler.getRegisteredEvents())
    }
    logger.debug("Completed registering event handlers")
}

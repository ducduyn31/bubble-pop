//
//  InitHandlers.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation
import os

protocol ClassSeparatedEventListener: EventListener {
    func getRegisteredEvents() -> [LocalEvent]
}

fileprivate let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: EventManager.self)
)
fileprivate let handlers: [ClassSeparatedEventListener] = [
    OnLoadComplete(),
    MoveFromLoadCompleted(),
]

func registerEventHandlers(eventManager: EventManager, context: AnyObject? = nil) {
    for handler in handlers {
        eventManager.registerListener(listener: handler, events: handler.getRegisteredEvents())
    }
    logger.debug("Completed registering event handlers")
}

//
//  Event.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import Foundation
import os

struct LocalEvent: Hashable, Equatable, CustomStringConvertible {
    
    let name: String
    let id = UUID()
    
    init(_ name: String) {
        self.name = name
    }
    
    static func == (lhs: LocalEvent, rhs: LocalEvent) -> Bool {
        return lhs.name == rhs.name
    }
    
    var description: String {
        return name
    }
}

protocol EventListener: AnyObject {
    func onEvent(event: LocalEvent, data: Any?, context: Any?)
}

/// Event manager for handling local events, this is how we implement Observer pattern
/// We aim to use this for inter-component communication to separate concerns
class EventManager {
    private var listeners: [LocalEvent: [EventListener]] = [:]
    private static let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: EventManager.self)
    )

    func registerListener(listener: EventListener, events: LocalEvent...) {
        registerListener(listener: listener, events: events)
    }
    
    func registerListener(listener: EventListener, events: [LocalEvent]) {
        for event in events {
            if listeners[event] == nil {
                listeners[event] = [EventListener]()
            }
            listeners[event]?.append(listener)
            Self.logger.debug("Registered listener for event: \(String(describing: event)), listener: \(String(describing: listener))")
        }
    }
    
    func unregisterListener(listener: EventListener, events: LocalEvent...) {
        unregisterListener(listener: listener, events: events)
    }
    
    func unregisterListener(listener: EventListener, events: [LocalEvent]) {
        for event in events {
            if let listeners = listeners[event] {
                self.listeners[event] = listeners.filter { $0 !== listener }
            }
        }
    }
    
    func publishEvent(event: LocalEvent, data: Any? = nil, context: Any? = nil) {
        Self.logger.debug("Publishing event: \(String(describing: event))")
        if let listeners = listeners[event] {
            for listener in listeners {
                listener.onEvent(event: event, data: data, context: context)
            }
        }
    }
}

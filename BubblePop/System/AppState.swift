//
//  AppState.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

enum AppState: Int, Comparable {
    case Loading = 0
    case LoadComplete = 1
    case GameMenu = 2
    case GamePlay = 3
    case GameOver = 4
    
    static func < (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func > (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

class SystemState: ObservableObject {
    @Published var state: AppState {
        didSet {
            systemEvent.publishEvent(event: .StateChanged, context: self)
        }
    }
    private var systemEvent: EventManager
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: SystemState.self))
    
    public init() {
        self.state = .Loading
        self.systemEvent = EventManager()
        registerEventHandlers(eventManager: self.systemEvent, context: self)
    }
    
    func publishEvent(event: LocalEvent, data: Any? = nil) {
        systemEvent.publishEvent(event: event, data: data, context: self)
    }
}


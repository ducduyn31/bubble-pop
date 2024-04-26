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

struct AlertMetadata {
    var title: String
    var message: String
}

/// Environment object to manage the state of the app
class SystemState: ObservableObject {
    @Published var state: AppState {
        didSet {
            systemEvent.publishEvent(event: .StateChanged, context: self) // Trigger event when state changes
        }
    }
    @Published var currentAlert: AlertMetadata?
    private var systemEvent: EventManager
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: SystemState.self))
    
    // To wire with SwiftUI `alert(isPresented:content:)`
    var isShowingAlert: Binding<Bool> {
        Binding<Bool>(
            get: { self.currentAlert != nil },
            set: { if !$0 { self.currentAlert = nil } }
        )
    }
    
    public init() {
        self.state = .Loading // Initial state
        self.systemEvent = EventManager()
        registerEventHandlers(eventManager: self.systemEvent, context: self)
    }
    
    func publishEvent(event: LocalEvent, data: Any? = nil) {
        systemEvent.publishEvent(event: event, data: data, context: self)
    }
}


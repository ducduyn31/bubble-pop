//
//  MoveFromLoadCompleted.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation
import os

extension LocalEvent {
    static let StateChanged = LocalEvent("StateChanged")
}

/// Creating a smooth transition from LoadComplete to GameMenu
class MoveFromLoadCompleted: ClassSeparatedEventListener {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: MoveFromLoadCompleted.self))
    
    func getRegisteredEvents() -> [LocalEvent] {
        return [.StateChanged]
    }
    
    func onEvent(event: LocalEvent, data: Any?, context: Any?) {
        guard let systemState = context as? SystemState else {
            return
        }
        
        guard systemState.state == .LoadComplete else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            systemState.state = .GameMenu
            self.logger.info("Moved to GameMenu")
        }
    }
}

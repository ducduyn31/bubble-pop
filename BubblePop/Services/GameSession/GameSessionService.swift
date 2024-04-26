//
//  GameSessionService.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import Foundation
import os

class GameSessionService {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameSessionService.self))
    private let gameSessionStore = GameSessionStore()
    
    /// Save the game session to the store, update the current instance
    func saveGameSession(gameSession: GameSession) {
        gameSessionStore.addGameSession(session: gameSession)
        try? gameSessionStore.saveGameSessions()
        logger.info("Game session saved: \(gameSession.id)")
    }
    
    func loadGameSessions() -> [GameSession] {
        try? gameSessionStore.loadGameSessions()
        logger.info("Game sessions loaded")
        return gameSessionStore.gameSessions
    }
    
    func getHighestScore() -> Int {
        let highscore = loadGameSessions().map({ $0.score }).max() ?? 0
        logger.info("Highscore: \(highscore)")
        return highscore
    }
}

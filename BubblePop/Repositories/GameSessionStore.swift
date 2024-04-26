//
//  GameSessionStore.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import Foundation
import os

class GameSessionStore: ObservableObject {
    @Published var gameSessions: [GameSession] = []
    private static let topK = 10
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameSessionStore.self))
    
    /// Save the high score to the gameSessions.json file
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("gameSessions.json")
    }
    
    /// When a new game completes, try to see if the game is in the top 10 high scores
    /// If it is, add it to the list and save it to the file. Only keeping top 10 high scores
    func addGameSession(session: GameSession) {
        try? self.loadGameSessions()
        gameSessions.append(session)
        gameSessions.sort { $0.score > $1.score }
        if gameSessions.count > Self.topK {
            gameSessions.removeLast()
        }
    }
    
    /// Load the game sessions from the file once the instance is created
    func loadGameSessions() throws {
        let url = try Self.fileURL()
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        gameSessions = try decoder.decode([GameSession].self, from: data)
        let count = gameSessions.count
        Self.logger.debug("Loaded \(count) game sessions")
    }
    
    /// Save the game sessions to the file
    func saveGameSessions() throws {
        let url = try Self.fileURL()
        let encoder = JSONEncoder()
        let data = try encoder.encode(gameSessions)
        try data.write(to: url)
    }
}

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
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("gameSessions.json")
    }
    
    func addGameSession(session: GameSession) {
        try? self.loadGameSessions()
        gameSessions.append(session)
        gameSessions.sort { $0.score > $1.score }
        if gameSessions.count > Self.topK {
            gameSessions.removeLast()
        }
    }
    
    func loadGameSessions() throws {
        let url = try Self.fileURL()
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        gameSessions = try decoder.decode([GameSession].self, from: data)
        let count = gameSessions.count
        Self.logger.debug("Loaded \(count) game sessions")
    }
    
    func saveGameSessions() throws {
        let url = try Self.fileURL()
        let encoder = JSONEncoder()
        let data = try encoder.encode(gameSessions)
        try data.write(to: url)
    }
}

//
//  GameViewModels.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation
import SwiftUI
import GameKit


class GameViewModel: ObservableObject, EventListener {
    @Inject var gameFactory: GameFactory
    @Inject var gameSessionService: GameSessionService
    private var game: Game?
    
    @Published var score: Int = 0
    @Published var time: Int = 0
    @Published var highscore: Int = 0
    @Published var bubbles: [Bubble] = []
    @Published var isGameOver: Bool = false
    @AppStorage("gameMode") var gameMode = 0

    func setupGame() {
        self.game = gameFactory.createGame(gameMode: gameMode)
        self.score = game?.score ?? 0
        self.highscore = gameSessionService.getHighestScore()
        self.time = game?.timeLeft ?? GameDuration[gameMode]
        self.isGameOver = false
    }
    
    func startGame(width: Double, height: Double) {
        game?.subscribeToGameEvents(listener: self)
        game?.updateSize(width: width, height: height)
        game?.startGame()
    }
    
    func resetGame() {
        game?.resetGame()
        self.score = game?.score ?? 0
        self.time = game?.timeLeft ?? GameDuration[gameMode]
        self.bubbles = game?.bubbles ?? []
        self.isGameOver = false
    }
    
    func popBubble(bubble: Bubble) {
        game?.popBubble(bubble: bubble)
    }
    
    func onEvent(event: LocalEvent, data: Any?, context: Any?) {
        switch event {
        case .TimeUpdated:
            self.time = game?.timeLeft ?? 0
        case .BubblesGenerated:
            self.bubbles = game?.bubbles ?? []
        case .ScoreUpdated:
            self.bubbles = game?.bubbles ?? []
            self.score = game?.score ?? 0
        case .GameOver:
            self.isGameOver = true
            self.highscore = max(self.highscore, self.score)
            let newGameSession = GameSession(
                id: UUID(),
                playerName: GKLocalPlayer.local.displayName,
                score: self.score,
                mode: self.gameMode,
                date: Date()
            )
            gameSessionService.saveGameSession(gameSession: newGameSession)
        default:
            break
        }
    }
    
    private static func dataStoreUrl() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("gameData.json")
    }
}
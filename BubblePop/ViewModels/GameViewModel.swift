//
//  GameViewModels.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation
import SwiftUI
import GameKit

/// The bridge between core game logic and the SwiftUI view
/// It communicates with game logic via Event based system
/// and update SwiftUI view via @Published properties
class GameViewModel: ObservableObject, EventListener {
    @Inject var gameFactory: GameFactory
    @Inject var gameSessionService: GameSessionService
    private var game: Game?
    
    @Published var score: Int = 0
    @Published var time: Int = 0
    @Published var highscore: Int = 0
    @Published var bubbles: [Bubble] = []
    @Published var isGameOver: Bool = false
    @Published var recentPopped: [Bubble] = []
    @AppStorage("gameMode") var gameMode = 0

    func setupGame() {
        self.game = gameFactory.createGame(gameMode: gameMode)
        self.score = game?.score ?? 0
        self.highscore = gameSessionService.getHighestScore()
        self.time = game?.timeLeft ?? GameDuration[gameMode]
        self.isGameOver = false
        game?.subscribeToGameEvents(listener: self) // Listen to the game events
    }
    
    func startGame(width: Double, height: Double) {
        game?.updateScreenSize(width: width, height: height)
        game?.startGame()
    }
    
    func resetGame() {
        // Reset the game: score, time, bubbles, game state
        game?.resetGame()
        self.score = game?.score ?? 0
        self.time = game?.timeLeft ?? GameDuration[gameMode]
        self.bubbles = game?.bubbles ?? []
        self.isGameOver = false
    }
    
    func popBubble(bubble: Bubble) {
        // Remove the bubble from the game, add it to the recent popped list to show the text effect, update the score
        game?.popBubble(bubble: bubble)
        recentPopped.append(bubble)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Once the text effect is done, remove the bubble from the recent popped list
            self.recentPopped.removeAll { $0.id == bubble.id }
        }
    }
    
    func removeBubble(bubble: Bubble) {
        game?.removeBubble(bubble: bubble)
    }
    
    func getBubbleScore(bubble: Bubble) -> Int {
        return Int(game?.getScore(bubble: bubble) ?? Int(bubble.score))
    }
    
    func getStreak(bubble: Bubble) -> Int {
        return game?.getStreak(bubble: bubble) ?? 1
    }
    
    /// Most important function in this class, this is where we update the view model based on the game state
    func onEvent(event: LocalEvent, data: Any?, context: Any?) {
        switch event {
        case .TimeUpdated:
            self.time = game?.timeLeft ?? 0 // Update the time countdown
        case .BubblesGenerated, .BubbleRemoved:
            self.bubbles = game?.bubbles ?? [] // When bubbles are generated or removed, update the view
        case .ScoreUpdated:
            self.score = game?.score ?? 0 // Update the score
        case .GameOver:
            // Stop the game, save the highscore and the game session
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
}

//
//  GameEngine.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation
import os

struct GameContext {
    var isStopped: Bool
    var timeLeft: Int
    var score: Int
    var gameDuration: Int
    var width: Double
    var height: Double
    var bubbles: [Bubble]
    var lastPoppedBubble: Bubble?
    var combo: Int
}

class Game {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: Game.self))
    private let gameEventManager: EventManager
    private let gameEvents: [LocalEvent] = [.TimeUpdated, .GameOver, .BubblesGenerated, .BubbleRemoved, .ScoreUpdated, .GamePaused, .GameStarted]
    private let maxStreak: Int = 10 // This is to prevent overflow, which will cause the app to crash
    private let streakMultiplier: Double
    private var context: GameContext
    private var timer: Timer?
    
    // Get only properties
    public var timeLeft: Int { get { return context.timeLeft } }
    public var score: Int { get { return context.score } }
    public var bubbles: [Bubble] { get { return context.bubbles } }
    
    @Inject private var bubbleFactory: BubbleFactory
    
    public init(gameDuration: Int) {
        self.gameEventManager = EventManager() // Every game has its own event manager
        self.context = GameContext(
            isStopped: true,
            timeLeft: gameDuration,
            score: 0,
            gameDuration: gameDuration,
            width: 0,
            height: 0,
            bubbles: [],
            combo: 0
        )
        self.streakMultiplier = 1.5 // Fixed for now
    }
    
    
    /// When the object is created, there is no information of how large the game area is
    /// This function allows the game to know the size of the game area
    func updateScreenSize(width: Double, height: Double) {
        context.width = width
        context.height = height
    }
    
    /// Start the game, start the timer, and generate bubbles
    func startGame() {
        timer?.invalidate()
        self.context.isStopped = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.context.timeLeft -= 1
            self.gameEventManager.publishEvent(event: LocalEvent.TimeUpdated, data: self.context.timeLeft, context: self.context)
            
            bubbleFactory.spawnBubbles(context: &context)
            self.gameEventManager.publishEvent(event: LocalEvent.BubblesGenerated, data: self.context.bubbles, context: self.context)
            
            if self.context.timeLeft <= 0 {
                self.endGame()
            }
        }
        gameEventManager.publishEvent(event: LocalEvent.GameStarted, data: nil, context: context)
    }
    
    /// Recycle the game object instead of recreating new game (expensive)
    func resetGame() {
        context.timeLeft = context.gameDuration
        context.score = 0
        context.bubbles = []
        context.combo = 0
        context.lastPoppedBubble = nil
    }
    
    func popBubble(bubble: Bubble) {
        if context.timeLeft == 0 || context.isStopped {
            return
        }
        let isCombo = context.lastPoppedBubble?.color == bubble.color
        context.combo = isCombo ? context.combo + 1 : 1     // Update the streak
        context.lastPoppedBubble = bubble                   // Remember the last bubble popped
        context.score += getScore(bubble: bubble)           // Update the score
        removeBubble(bubble: bubble)                        // Remove the bubble
        gameEventManager.publishEvent(event: LocalEvent.ScoreUpdated, data: context.score, context: context)
    }
    
    /// System call only, this will force the bubble to be removed from the game without updating the score
    func removeBubble(bubble: Bubble) {
        if let index = context.bubbles.firstIndex(where: { $0.id == bubble.id }) {
            context.bubbles.remove(at: index)
        }
        gameEventManager.publishEvent(event: LocalEvent.BubbleRemoved, data: context.bubbles, context: context)
    }
    
    /// Calculate the multiplier for the bubble, The first ball has the base score, every ball after that will update the score
    /// with 1.5 times of the last ball's score
    func getMultiplier(bubble: Bubble) -> Double {
        let isCombo = context.lastPoppedBubble?.color == bubble.color
        
        if !isCombo {
            return 1
        }
        
        let lastStreak = context.combo
        return pow(streakMultiplier, Double(min(lastStreak, maxStreak)))
    }
    
    /// Showing the COMBO streak
    func getStreak(bubble: Bubble) -> Int {
        let isCombo = context.lastPoppedBubble?.color == bubble.color
        return isCombo ? context.combo : 1
    }
    
    /// Calculate the score for the bubble. The first ball has the base score, every ball after that will update the score
    /// with 1.5 times of the last ball's score
    func getScore(bubble: Bubble) -> Int {
        let multiplier = getMultiplier(bubble: bubble)
        return Int(multiplier * Double(bubble.score))
    }
    
    func stopGame() {
        timer?.invalidate()
        timer = nil
        self.context.isStopped = true
        gameEventManager.publishEvent(event: LocalEvent.GamePaused, data: nil)
    }
    
    func endGame() {
        timer?.invalidate()
        timer = nil
        self.context.isStopped = true
        gameEventManager.publishEvent(event: LocalEvent.GameOver, data: nil)
    }
    
    /// A helper function to provide with easy subscriptions to all game events
    func subscribeToGameEvents(listener: EventListener) {
        gameEventManager.registerListener(listener: listener, events: gameEvents)
    }
}

extension LocalEvent {
    static let TimeUpdated = LocalEvent("TimeUpdated")
    static let BubblesGenerated = LocalEvent("BubblesGenerated")
    static let ScoreUpdated = LocalEvent("ScoreUpdated")
    static let BubbleRemoved = LocalEvent("BubbleRemoved")
    static let GameStarted = LocalEvent("GameStarted")
    static let GamePaused = LocalEvent("GamePaused")
    static let GameOver = LocalEvent("GameOver")
}

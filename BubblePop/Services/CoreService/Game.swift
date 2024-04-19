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
    private var timer: Timer?
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: Game.self))
    private let gameEventManager: EventManager
    private let gameEvents: [LocalEvent] = [.TimeUpdated, .GameOver, .BubblesGenerated, .ScoreUpdated, .GamePaused, .GameStarted]
    private var context: GameContext
    
    public var timeLeft: Int { get { return context.timeLeft } }
    public var score: Int { get { return context.score } }
    public var bubbles: [Bubble] { get { return context.bubbles } }
    
    @Inject private var bubbleFactory: BubbleFactory
    
    public init(gameDuration: Int) {
        self.gameEventManager = EventManager()
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
    }
    
    func updateSize(width: Double, height: Double) {
        context.width = width
        context.height = height
    }
    
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
    
    func resetGame() {
        context.timeLeft = context.gameDuration
        context.score = 0
        context.bubbles = []
    }
    
    func popBubble(bubble: Bubble) {
        if context.timeLeft == 0 || context.isStopped {
            return
        }
        let isCombo = context.lastPoppedBubble?.color == bubble.color
        if let index = context.bubbles.firstIndex(where: { $0.id == bubble.id }) {
            context.bubbles.remove(at: index)
            context.combo = isCombo ? context.combo + 1 : 1
            let multiplier: Double = context.combo > 1 ? pow(1.5, Double(context.combo - 1)) : 1
            context.score += Int(multiplier * Double(bubble.score))
            context.lastPoppedBubble = bubble
            gameEventManager.publishEvent(event: LocalEvent.ScoreUpdated, data: context.score, context: context)
        }
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
    
    func subscribeToGameEvents(listener: EventListener) {
        gameEventManager.registerListener(listener: listener, events: gameEvents)
    }
}

extension LocalEvent {
    static let TimeUpdated = LocalEvent("TimeUpdated")
    static let BubblesGenerated = LocalEvent("BubblesGenerated")
    static let ScoreUpdated = LocalEvent("ScoreUpdated")
    static let GameStarted = LocalEvent("GameStarted")
    static let GamePaused = LocalEvent("GamePaused")
    static let GameOver = LocalEvent("GameOver")
}

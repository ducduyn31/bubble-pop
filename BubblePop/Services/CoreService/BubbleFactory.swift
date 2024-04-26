//
//  BubbleFactory.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation

/// Generate bubbles based on the game mode
class BubbleFactory {
    let generateStrategy: IBubbleGenerateStrategy
    let degenerateStrategy: IBubbleDegenerateStrategy
    
    init(generateStrategy: IBubbleGenerateStrategy, degenerateStrategy: IBubbleDegenerateStrategy) {
        self.generateStrategy = generateStrategy
        self.degenerateStrategy = degenerateStrategy
    }
    
    func spawnBubbles(context: inout GameContext, count: Int = 0, bubbleSize: BubbleSize = .Medium, bubbleColor: BubbleColor = .Red) {
        let currentGameMode = UserDefaults.standard.integer(forKey: "gameMode")
        let toSpawn = count > 0 ? count : Int.random(in: GameMinBubblePerTurn[currentGameMode]...GameMaxBubbles[currentGameMode])
        
        for _ in 0..<toSpawn {
            // Generate a bubble
            let bubble = generateStrategy.generateBubble(context: context)
            if bubble == nil {
                continue
            }
            context.bubbles.append(bubble!)
        }
        
        // If the number of bubbles exceed the limit, remove the oldest bubbles
        let toRemove = context.bubbles.count - GameMaxBubbles[currentGameMode]
        if toRemove > 0 {
            context.bubbles.removeFirst(toRemove)
        }
    }
}

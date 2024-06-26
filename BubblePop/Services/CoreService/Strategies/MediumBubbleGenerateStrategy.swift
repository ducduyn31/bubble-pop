//
//  MediumBubbleStrategy.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation
import UIKit

/// Generate bubble strategy for medium difficulty
/// - Probability: Red (40%), Pink (30%), Green (15%), Blue (10%), Black (5%)
/// - Velocity: Red (100), Pink (150), Green (200), Blue (250), Black (300)
///
/// Prevent the bubble from overlapping and showing outside the screen
class MediumBubbleGenerateStrategy: IBubbleGenerateStrategy {
    private let probability: [BubbleColor: Double] = [
        .Red: 0.4,
        .Pink: 0.3,
        .Green: 0.15,
        .Blue: 0.1,
        .Black: 0.05,
    ]
    
    private let bubbleVelocity: [BubbleColor: Double] = [
        .Red: 100.0,
        .Pink: 150.0,
        .Green: 200.0,
        .Blue: 250.0,
        .Black: 300.0,
    ]
    
    func generateBubble(context: GameContext) -> Bubble? {
        let color = selectRandomColor()
        if color == nil {
            return nil
        }
        let size: BubbleSize = .Medium
        
        let screenHeight = context.height
        let screenWidth = context.width
        
        let maxTries = 100 // Maximum tries to prevent infinite loop
        for _ in 0..<maxTries {
            let x = Double.random(in: 0...screenWidth)
            let y = Double.random(in: screenHeight/2...screenHeight)
            let velocity = bubbleVelocity[color!]!
            if !isOverlapping(context: context, x: x, y: y) {
                return Bubble(
                    id: UUID(),
                    color: color!,
                    size: size,
                    score: BubbleScore[color!]!,
                    position: BubblePosition(initialX: x, initialY: y, velocity: velocity)
                )
            }
        }
        return nil
    }
    
    private func isOverlapping(context: GameContext, x: Double, y: Double) -> Bool {
        let radius = BubbleRadius[.Medium]!
        if x - radius < 0 || x + radius > context.width || y - radius < 0 || y + radius > context.height {
            // Bubble is showing outside the screen, prevent this
            return true
        }
        
        for bubble in context.bubbles {
            let distance = sqrt(pow(bubble.x - x, 2) + pow(bubble.y - y, 2)) // Euclidean distance between centers
            if distance < radius + BubbleRadius[bubble.size]! {
                // Bubble is overlapping (including the radius), prevent this
                return true
            }
        }
        return false
    }
    
    private func selectRandomColor() -> BubbleColor? {
        let random = Double.random(in: 0...1)
        var sum = 0.0
        for (color, prob) in probability {
            sum += prob
            if random <= sum {
                return color
            }
        }
        return nil
    }
}

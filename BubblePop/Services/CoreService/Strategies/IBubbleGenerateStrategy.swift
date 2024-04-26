//
//  IBubbleGenerateStrategy.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation

/// Strategy for generating bubbles
protocol IBubbleGenerateStrategy {
    func generateBubble(context: GameContext) -> Bubble?
}

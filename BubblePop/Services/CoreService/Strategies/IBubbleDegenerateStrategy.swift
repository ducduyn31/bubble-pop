//
//  IBubbleDegenerateStrategy.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation

protocol IBubbleDegenerateStrategy {
    func degenerateBubbles(context: GameContext) -> [Bubble]
}

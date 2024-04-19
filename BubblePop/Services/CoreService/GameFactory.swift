//
//  GameFactory.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import Foundation
import os

let GameDuration = [90, 60, 30]
let GameMaxBubbles = [15, 15, 25]
let GameMaxPerTurn = [5, 7, 10]
let GameMinBubblePerTurn = [1, 3, 10]

class GameFactory {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing:  GameFactory.self))
    
    func createGame(gameMode: Int = 0) -> Game {
        Self.logger.debug("Creating game with mode \(gameMode)")
        return Game(gameDuration: GameDuration[gameMode])
    }
}

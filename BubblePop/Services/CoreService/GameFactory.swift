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

/// Factory class to create a game, at this point it is very simple
/// but when more ideas for game modes are introduced, this class will be
/// the place to handle the creation of different game modes
///
/// I currently consider all 3 game modes to be the same, with different time duration and bubble generated
///
/// Later on I can introduce more sophisticated bubble behaviors, powerups, etc.
class GameFactory {
    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing:  GameFactory.self))
    
    func createGame(gameMode: Int = 0) -> Game {
        Self.logger.debug("Creating game with mode \(gameMode)")
        return Game(gameDuration: GameDuration[gameMode])
    }
}

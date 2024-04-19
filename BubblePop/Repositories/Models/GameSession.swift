//
//  GameSession.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import SwiftUI

struct GameSession: Identifiable, Codable, Hashable {
    let id: UUID
    let playerName: String
    let score: Int
    let mode: Int
    let date: Date
}

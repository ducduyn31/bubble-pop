//
//  Bubble.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation
import SwiftUI

enum BubbleColor: CaseIterable {
    case Red
    case Green
    case Blue
    case Pink
    case Black
    
    func toColor() -> Color {
        switch self {
        case .Red:
            return Color.red
        case .Green:
            return Color.green
        case .Blue:
            return Color.blue
        case .Pink:
            return Color.purple
        case .Black:
            return Color.black
        }
    }
}

enum BubbleSize: CaseIterable {
    case Small
    case Medium
    case Large
}

struct BubblePosition {
    var initialX: Double
    var initialY: Double
    var velocity: Double
}

let BubbleRadius: [BubbleSize: Double] = [
    .Small: 30,
    .Medium: 50,
    .Large: 70,
]

let BubbleScore: [BubbleColor: Double] = [
    .Red: 1,
    .Pink: 2,
    .Green: 5,
    .Blue: 8,
    .Black: 10,
]

/// Dataclass for Bubble
class Bubble: Identifiable, Equatable {
    var id: UUID
    var color: BubbleColor
    var size: BubbleSize
    var position: BubblePosition
    var score: Double
    var createdAt: Date = Date()
    
    var x: Double {
        get {
            return position.initialX
        }
    }
    
    var y: Double {
        get {
            // Bubble floats but I don't want to continuously update the position, it will cause
            // write update (expensive). Thus I estimate the position based on the initial position
            // and the velocity, this will be much cheaper.
            return position.initialY - (Date().timeIntervalSince(createdAt) * position.velocity)
        }
    }
    
    init(id: UUID, color: BubbleColor, size: BubbleSize, score: Double, position: BubblePosition) {
        self.id = id
        self.color = color
        self.size = size
        self.position = position
        self.score = score
    }
    
    static func == (lhs: Bubble, rhs: Bubble) -> Bool {
        return lhs.id == rhs.id
    }
}

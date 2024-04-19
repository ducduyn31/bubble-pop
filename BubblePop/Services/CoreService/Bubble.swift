//
//  Bubble.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import Foundation

enum BubbleColor: CaseIterable {
    case Red
    case Green
    case Blue
    case Pink
    case Black
}

enum BubbleSize: CaseIterable {
    case Small
    case Medium
    case Large
}

struct BubblePosition {
    var x: Double
    var y: Double
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

class Bubble: Identifiable {
    var id: UUID
    var color: BubbleColor
    var size: BubbleSize
    var position: BubblePosition
    var score: Double
    
    init(id: UUID, color: BubbleColor, size: BubbleSize, score: Double, position: BubblePosition) {
        self.id = id
        self.color = color
        self.size = size
        self.position = position
        self.score = score
    }
}

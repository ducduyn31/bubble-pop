//
//  Ball.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI
import os

struct Ball: View, Equatable {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: Ball.self))
    let bubble: Bubble
    let onTapped: (Bubble) -> Void
    private let imageName: [BubbleColor: String] = [
        .Red: "RedBall",
        .Green: "GreenBall",
        .Blue: "BlueBall",
        .Pink: "PinkBall",
        .Black: "BlackBall",
    ]
    
    var body: some View {
        Image(imageName[bubble.color]!)
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                onTapped(bubble)
            }
    }
    
    static func == (lhs: Ball, rhs: Ball) -> Bool {
        return lhs.bubble == rhs.bubble
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var count = 0
        @State var bubble = Bubble(id: UUID(), color: .Red, size: .Medium, score: 1, position: BubblePosition(initialX: 0.5, initialY: 0.5, velocity: 100))
        
        var body: some View {
            VStack {
                Text("""
                     Count: \(count),
                     Color: \(bubble.color),
                     Size: \(bubble.size),
                     Position: \(bubble.position.initialX), \(bubble.position.initialY),
                     Id: \(bubble.id)
                     """)
                Ball(bubble: bubble) { _ in 
                    count += 1
                    let randomColor = BubbleColor.allCases.randomElement()!
                    let randomSize = BubbleSize.allCases.randomElement()!
                    let position = BubblePosition(initialX: Double.random(in: 0...1), initialY: Double.random(in: 0...1), velocity: 100)
                    bubble = Bubble(id: UUID(), color: randomColor, size: randomSize, score: 1, position: position)
                }
            }
        }
    }
    return PreviewWrapper()
}

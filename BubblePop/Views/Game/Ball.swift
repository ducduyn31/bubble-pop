//
//  Ball.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI
import os

struct Ball: View {
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
}

#Preview {
    struct PreviewWrapper: View {
        @State var count = 0
        @State var bubble = Bubble(id: UUID(), color: .Red, size: .Medium, score: 1, position: BubblePosition(x: 0.5, y: 0.5))
        
        var body: some View {
            VStack {
                Text("""
                     Count: \(count),
                     Color: \(bubble.color),
                     Size: \(bubble.size),
                     Position: \(bubble.position.x), \(bubble.position.y),
                     Id: \(bubble.id)
                     """)
                Ball(bubble: bubble) { _ in 
                    count += 1
                    let randomColor = BubbleColor.allCases.randomElement()!
                    let randomSize = BubbleSize.allCases.randomElement()!
                    let position = BubblePosition(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
                    bubble = Bubble(id: UUID(), color: randomColor, size: randomSize, score: 1, position: position)
                }
            }
        }
    }
    return PreviewWrapper()
}

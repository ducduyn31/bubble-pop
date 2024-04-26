//
//  PoppedTextEffect.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import SwiftUI

/// A view that displays a text effect when a bubble is popped then fades out
struct PoppedTextEffect: View {
    // If subscribed to the view model, the text effect will show the double displayed bug
    // due to the score is updated thus cause the view to rerender
    let viewModel: GameViewModel
    let poppedBubble: Bubble
    private let randomRange = -30.0...30.0
    
    
    var body: some View {
        let isCombo = viewModel.getStreak(bubble: poppedBubble) > 1
        VStack {
            if isCombo {
                Text("COMBO \(viewModel.getStreak(bubble: poppedBubble))")
                    .bold()
                    .font(.title)
                    .foregroundColor(poppedBubble.color.toColor())
                    .background(.clear)
            }
            Text("+\(viewModel.getBubbleScore(bubble: poppedBubble))".clamp(maxChars: 6))
                .bold()
                .foregroundColor(poppedBubble.color.toColor())
                .background(.clear)
        }
        .transition(.opacity)
        .position(self.getPosition())
        .fading(duration: 1.0, from: 1.0, to: 0)
    }
    
    /// Display the text around the popped bubble
    private func getPosition() -> CGPoint {
        let x = poppedBubble.x + Double.random(in: randomRange)
        let y = poppedBubble.y + Double.random(in: randomRange)
        return CGPoint(x: x, y: y)
    }
}

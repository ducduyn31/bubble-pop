//
//  PoppedTextEffect.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import SwiftUI

struct PoppedTextEffect: View {
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
    
    private func getPosition() -> CGPoint {
        let x = poppedBubble.x + Double.random(in: randomRange)
        let y = poppedBubble.y + Double.random(in: randomRange)
        return CGPoint(x: x, y: y)
    }
}

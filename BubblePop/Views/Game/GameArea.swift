//
//  GameArea.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI
import os

struct GameArea: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameArea.self))
    @ObservedObject var viewModel: GameViewModel
    @Inject var soundPlayer: SoundPlayerService
    let shouldStart: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.bubbles, id: \.id) { bubble in
                    Ball(bubble: bubble) { bubble in
                        viewModel.popBubble(bubble: bubble)
                        soundPlayer.playSound(name: .bubblePop)
                    }
                        .position(x: bubble.position.initialX, y: bubble.position.initialY) // Initial Position
                        .floatUp(
                            initialY: bubble.position.initialY,
                            velocity: bubble.position.velocity
                        ) {
                            viewModel.removeBubble(bubble: bubble)
                        }
                }
                
                ForEach(viewModel.recentPopped, id: \.id) { poppedBubble in
                    PoppedTextEffect(
                        viewModel: viewModel,
                        poppedBubble: poppedBubble
                    )
                }
            }
            .onChange(of: shouldStart) { _, shouldStart in
                if shouldStart {
                    viewModel.startGame(width: geometry.size.width, height: geometry.size.height)
                    soundPlayer.playSound(name: .backgroundLoop, isLooped: true)
                }
            }
        }
    }
}

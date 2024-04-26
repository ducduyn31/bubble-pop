//
//  GameArea.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI
import os

/// The game area where the bubbles are rendered
struct GameArea: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameArea.self))
    @ObservedObject var viewModel: GameViewModel
    @Inject private var soundPlayer: SoundPlayerService
    let shouldStart: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.bubbles, id: \.id) { bubble in
                    Ball(bubble: bubble) { bubble in
                        viewModel.popBubble(bubble: bubble) // Pop the bubble when it's tapped, trigger score and bubble events
                        soundPlayer.playSound(name: .bubblePop)
                    }
                        .position(x: bubble.position.initialX, y: bubble.position.initialY) // Initial Position
                        .floatUp(
                            initialY: bubble.position.initialY,
                            velocity: bubble.position.velocity
                        ) {
                            // Once the bubble is out of the screen, remove it from the game
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
                // Only actually start the game when the game area is ready
                if shouldStart {
                    viewModel.startGame(width: geometry.size.width, height: geometry.size.height)
                    soundPlayer.playSound(name: .backgroundLoop, isLooped: true)
                }
            }
        }
    }
}

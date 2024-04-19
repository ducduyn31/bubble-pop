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
    let shouldStart: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(viewModel.bubbles, id: \.id) { bubble in
                    Ball(bubble: bubble) { bubble in
                        viewModel.popBubble(bubble: bubble)
                    }
                        .position(x: bubble.position.x, y: bubble.position.y)
                }
            }
            .onChange(of: shouldStart) { _, shouldStart in
                if shouldStart {
                    viewModel.startGame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

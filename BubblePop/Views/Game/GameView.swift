//
//  GameView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct GameView: DestinationView {
    @EnvironmentObject var systemState: SystemState
    @StateObject var viewModel: GameViewModel = GameViewModel()
    @State private var isCountingdown = true
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameView.self))
    
    var name = "Start"
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            Countdown(shouldCountdown: $isCountingdown)
            VStack {
                Banner(time: viewModel.time, score: viewModel.score, highscore: viewModel.highscore)
                GameArea(viewModel: viewModel, shouldStart: !isCountingdown)
            }
            if viewModel.isGameOver {
                // When the game is over, show the game over overlay, which will prevent user from interacting with the game
                GameOverOverlay(isCountingdown: $isCountingdown, viewModel: viewModel)
            }
        }
        .onAppear {
            self.isCountingdown = true // Start the countdown, this will trigger Countdown component to start counting down
            viewModel.setupGame() // Setup the game, subscribe to logic events
            logger.debug("GameView appeared")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    loadDependeciencies()
    configureDefaultSettings()
    return GameView()
}

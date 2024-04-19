//
//  GameView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct GameView: View {
    @EnvironmentObject var systemState: SystemState
    @StateObject var viewModel: GameViewModel = GameViewModel()
    @State private var isCountingdown = true
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameView.self))
    
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
                GameOverOverlay(isCountingdown: $isCountingdown, viewModel: viewModel)
            }
        }
        .onAppear {
            self.isCountingdown = true
            viewModel.setupGame()
            logger.debug("GameView appeared")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    loadDependeciencies()
    configureSettings()
    return GameView()
}

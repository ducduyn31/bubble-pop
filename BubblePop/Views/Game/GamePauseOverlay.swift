//
//  GamePauseOverlay.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import SwiftUI

struct GamePauseOverlay: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        Card {
            VStack {
                Text("Game Paused")
                    .font(.largeTitle)
                    .padding()
                Text("Score: \(viewModel.score)")
                    .font(.title)
                    .padding()
                Button(action: {
                    
                }) {
                    Text("Resume")
                        .font(.title)
                        .padding()
                }
                Button(action: {
                    // Go back to main menu
                }) {
                    Text("Main Menu")
                        .font(.title)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    GamePauseOverlay(viewModel: GameViewModel())
}

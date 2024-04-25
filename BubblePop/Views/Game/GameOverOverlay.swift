//
//  EndGameView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import SwiftUI

struct GameOverOverlay: View {
    @Binding var isCountingdown: Bool
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Card {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .padding()
                    Text("Score: \(viewModel.score)")
                        .font(.title)
                        .padding()
                    FancyButton(action: {
                        viewModel.resetGame()
                        isCountingdown = true
                    }) {
                        Text("Restart")
                            .font(.title)
                            .padding()
                    }
                    FancyButton(action: {
                        dismiss()
                    }) {
                        Text("Main Menu")
                            .font(.title)
                            .padding()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    loadDependeciencies()
    return GameOverOverlay(isCountingdown: .constant(false), viewModel: GameViewModel())
}

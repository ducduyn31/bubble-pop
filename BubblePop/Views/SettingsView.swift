//
//  SettingsView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct SettingsView: DestinationView {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: SettingsView.self))
    @Environment(\.dismiss) var dismiss
    @AppStorage("gameMode") var gameMode = 0
    
    var name = "Settings"
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                FancyButton(action: { selectGameMode(0) }) {
                    Image("EasyMode")
                        .resizable()
                        .selectable(gameMode == 0)
                }
                FancyButton(action: { selectGameMode(1) }) {
                    Image("NormalMode")
                        .resizable()
                        .selectable(gameMode == 1)
                }
                FancyButton(action: { selectGameMode(2) }) {
                    Image("HardMode")
                        .resizable()
                        .selectable(gameMode == 2)
                }
                FancyButton(action: {
                    dismiss()
                }) {
                    Image("Ok")
                        .resizable()
                        .frame(width: 200, height: 100)
                        .padding()
                }
            }
        }
        .onAppear {
            logger.debug("SettingsView appeared")
        }
        .navigationBarBackButtonHidden()
    }
    
    /// Select game mode
    /// mode: 0 = Easy, 1 = Normal, 2 = Hard
    /// At this point the game mode is only different in the game duration and how many bubbles are generated
    private func selectGameMode(_ mode: Int) {
        gameMode = mode
        logger.debug("Game mode changed to \(mode)")
    }
}

#Preview {
    loadDependeciencies()
    return SettingsView()
}

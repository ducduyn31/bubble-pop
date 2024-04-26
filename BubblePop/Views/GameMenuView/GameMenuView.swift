//
//  GameMenuView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

protocol DestinationView: View {
    var name: String { get }
}

struct GameMenuView: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: GameMenuView.self))
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Image("Title")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
                MenuButton(destination: GameView())
                MenuButton(destination: SettingsView())
                MenuButton(destination: HighScoreView(store: GameSessionStore()))
                Spacer()
            }
            .fading(duration: 2, from: 0, to: 1) // Slowly reveal the menu
        }
        .onAppear {
            logger.debug("GameMenuView appeared")
        }
    }
}

#Preview {
    loadDependeciencies()
    return GameMenuView()
}

//
//  GameMenuView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct GameMenuView: View {
    @Inject private var gameFactory: GameFactory
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
                NavigationLink(
                    destination:
                        GameView()
                ) {
                    Image("Start")
                        .resizable()
                        .frame(width: 200, height: 100)
                }
                NavigationLink(
                    destination:
                        SettingsView()
                ) {
                    Image("Settings")
                        .resizable()
                        .frame(width: 200, height: 100)
                }
                NavigationLink(
                    destination:
                        HighScoreView(store: GameSessionStore())
                ) {
                    Image("Highscore")
                        .resizable()
                        .frame(width: 200, height: 100)
                }
                Spacer()
            }
            .fading(duration: 2, from: 0, to: 1)
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

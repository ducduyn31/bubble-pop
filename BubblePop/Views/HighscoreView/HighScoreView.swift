//
//  HighScoreView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct HighScoreView: DestinationView {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: HighScoreView.self))
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: GameSessionStore
    
    var name = "Highscore"
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Image("HallOfFame")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .padding()
                HighScoreList(store: store)
                Spacer()
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
            logger.debug("HighScoreView appeared")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    loadDependeciencies()
    return HighScoreView(store: GameSessionStore())
}

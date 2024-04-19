//
//  HighScoreView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI
import os

struct HighScoreView: View {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: HighScoreView.self))
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: GameSessionStore
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Image("HallOfFame")
                    .resizable()
                    .frame(width: 300, height: 100)
                    .padding()
                List {
                    ForEach(store.gameSessions.indices, id: \.self) { id in
                        HStack {
                            Text("\(id + 1)")
                                .font(id == 0 ? .title : .headline)
                            Text(store.gameSessions[id].playerName.or("Anonymous"))
                                .font(id == 0 ? .title : .headline)
                            Spacer()
                            Text("\(store.gameSessions[id].score)")
                                .font(id == 0 ? .title : .headline)
                        }
                        .background(.clear)
                        .listRowBackground(Color.clear)
                    }
                }.listStyle(PlainListStyle())
                Spacer()
                Button(action: {
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
            try? store.loadGameSessions()
            logger.debug("HighScoreView appeared")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HighScoreView(store: GameSessionStore())
}

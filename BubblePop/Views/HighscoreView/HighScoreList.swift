//
//  HighScoreList.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import SwiftUI

struct HighScoreList: View {
    @ObservedObject var store: GameSessionStore
    
    var body: some View {
        List {
            ForEach(store.gameSessions.indices, id: \.self) { id in
                HStack {
                    Text("\(id + 1).")
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
        .onAppear {
            try? store.loadGameSessions() // Load game sessions from stored file
        }
    }
}

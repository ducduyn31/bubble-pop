//
//  HintText.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import SwiftUI

fileprivate let Hints = [
    "The game supports both light and dark mode",
    "You can change the game difficulty in the Setting tab",
    "Compounded interest? What about compounded score?",
    "Red bubbles have the least score",
    "Black bubbles have the most score",
    "Red bubbles appear more frequently than black bubbles",
    "Maximum streak is 10, so keep popping!",
]

struct HintText: View {
    @State private var currentHint = Hints.randomElement()!
    private var timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    var body: some View {
        Text("Hints:")
            .font(.title2)
            .padding(.horizontal)
        Text(currentHint)
            .font(.title3)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.bottom)
            .onReceive(timer) { _ in
                currentHint = Hints.randomElement()!
            }
    }
}

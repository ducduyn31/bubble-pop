//
//  Logo.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image("SplashIcon")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding()
            .blinking(from: 1, to: 0.5)
        Text("A product of Coffee with Egg")
            .font(.title)
        Text("with the help of TextStudio")
            .font(.title3)
            .delay(duration: 2)
        Text("and Freesound.org")
            .font(.title3)
            .delay(duration: 4)
    }
}

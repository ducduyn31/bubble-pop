//
//  FancyButton.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import SwiftUI

/// Just a button that plays sound when tapped.
struct FancyButton<Label>: View where Label: View {
    @Inject private var soundPlayer: SoundPlayerService
    let action: () -> Void
    let viewBuilder: () -> Label
    
    var body: some View {
        Button(action: {
            soundPlayer.playSound(name: .menuClick)
            action()
        }, label: viewBuilder)
    }
}

#Preview {
    loadDependeciencies()
    return FancyButton(action: {}) {
        Text("Hello, World!")
    }
}

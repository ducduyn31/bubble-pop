//
//  FancyButton.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import SwiftUI

struct FancyButton<Label>: View where Label: View {
    @Inject var soundPlayer: SoundPlayerService
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

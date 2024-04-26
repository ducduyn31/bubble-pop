//
//  MenuButton.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import SwiftUI

/// A button that navigates to a destination view and play sound when tapped.
/// It is just a wrapper around NavigationLink with a tap gesture.
struct MenuButton: View {
    @Inject private var soundPlayer: SoundPlayerService
    let destination: any DestinationView
    
    var body: some View {
        NavigationLink(
            destination:
                AnyView(destination)
        ) {
            Image(destination.name)
                .resizable()
                .frame(width: 200, height: 100)
        }
        .simultaneousGesture(TapGesture().onEnded {
            soundPlayer.playSound(name: .menuClick)
        })
    }
}

//
//  Delay.swift
//  BubblePop
//
//  Created by Duy Nguyen on 26/4/2024.
//

import SwiftUI

/// A view modifier that delays the appearance of the vie, then slowly reveals it
struct Delay: ViewModifier {
    let duration: Double
    let revealDuration: Double
    
    @State private var isHidden = true
    
    func body(content: Content) -> some View {
        content
            .opacity(isHidden ? 0 : 1)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation(.easeInOut(duration: revealDuration)) {
                        isHidden = false
                    }
                }
            }
    }
}

extension View {
    func delay(duration: Double, revealDuration: Double = 1) -> some View {
        self.modifier(Delay(duration: duration, revealDuration: revealDuration))
    }
}

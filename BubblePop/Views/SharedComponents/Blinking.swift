//
//  Blinking.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import SwiftUI

struct BlinkingViewModifier: ViewModifier {
    let duration: Double
    let from: Double
    let to: Double
    
    @State private var opacity: Double
    
    init(duration: Double, from: Double, to: Double) {
        self.duration = duration
        self.from = from
        self.to = to
        self.opacity = from
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: duration).repeatForever()) {
                    self.opacity = to
                }
            }
    }
}

extension View {
    func blinking(duration: Double = 1.0, from: Double = 0.0, to: Double = 1.0) -> some View {
        self.modifier(BlinkingViewModifier(duration: duration, from: from, to: to))
    }
}

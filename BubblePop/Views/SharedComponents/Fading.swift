//
//  Fading.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import SwiftUI

struct FadingViewModifier: ViewModifier {
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
                withAnimation(.easeInOut(duration: duration)) {
                    self.opacity = to
                }
            }
    }
}

extension View {
    func fading(duration: Double = 1.0, from: Double = 1.0, to: Double = 0.0) -> some View {
        self.modifier(FadingViewModifier(duration: duration, from: from, to: to))
    }
}

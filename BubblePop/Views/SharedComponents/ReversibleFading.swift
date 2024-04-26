//
//  ConditionalFading.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import SwiftUI

/// A view modifier that makes the view fading in and out conditionally
struct ReversibleFadingViewModifier: ViewModifier {
    let duration: Double
    let from: Double
    let to: Double
    
    @Binding var shouldReverse: Bool
    @State private var opacity: Double
    
    init(duration: Double, from: Double, to: Double, shouldReverse: Binding<Bool>) {
        self.duration = duration
        self.from = from
        self.to = to
        self._shouldReverse = shouldReverse
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
            .onChange(of: shouldReverse) { _, shouldReverse in
                if shouldReverse {
                    withAnimation(.easeInOut(duration: duration)) {
                        self.opacity = from
                    }
                }
            }
    }
}

extension View {
    func reversibleFading(shouldReverse: Binding<Bool>, duration: Double = 1.0, from: Double = 0.0, to: Double = 1.0) -> some View {
        self.modifier(ReversibleFadingViewModifier(duration: duration, from: from, to: to, shouldReverse: shouldReverse))
    }
}

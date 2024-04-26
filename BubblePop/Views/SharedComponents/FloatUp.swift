//
//  FloatUp.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import SwiftUI

/// A view modifier that makes the view floating up based on the given velocity
/// This is used in making the bubble floating up
struct FloatUp: ViewModifier {
    let initialY: Double
    let velocity: Double
    let callback: () -> Void
    
    @State private var yOffset: Double = 0
    
    init(initialY: Double, velocity: Double, callback: @escaping () -> Void) {
        self.initialY = initialY
        self.velocity = velocity
        self.callback = callback
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: yOffset)
            .onAppear {
                startMoving()
            }
    }
    
    private func startMoving() {
        let distance = initialY
        let duration = distance / velocity
        withAnimation(.linear(duration: duration)) {
            yOffset = -distance
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            callback()
        }
    }
}

extension View {
    func floatUp(initialY: Double, velocity: Double, callback: @escaping () -> Void) -> some View {
        self.modifier(FloatUp(initialY: initialY, velocity: velocity, callback: callback))
    }
}

//
//  Timer.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Combine
import SwiftUI

/// A view modifier that makes  trigger an action every interval
/// if `repeat` is set to true, the action will be triggered every interval such as counting down
/// if `repeat` is set to false, the action will be triggered once such as a timeout
struct TimerViewModifier: ViewModifier {
    @State private var timer: Timer.TimerPublisher
    @Binding private var handler: Cancellable?
    
    private let every: TimeInterval
    private let `repeat`: Bool
    private let callback: ((Cancellable) -> Void)
    
    init(_ handler: Binding<Cancellable?>, every: TimeInterval, `repeat`: Bool = true, callback: @escaping (Cancellable) -> Void) {
        self.every = every
        self.`repeat` = `repeat`
        self.callback = callback
        
        
        let publisher = Timer.publish(every: every, on: .main, in: .default)
        self._handler = handler
        self._timer = .init(initialValue: publisher)
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                self.setTimer()
            }
            .onReceive(timer) { _ in
                if !`repeat` {
                    self.cancelTimer()
                }
                if let handler = self.handler {
                    self.callback(handler)
                }
            }
            .onDisappear {
                self.cancelTimer()
            }
    }
    
    private func setTimer() {
        self.handler?.cancel()
        timer = Timer.publish(every: every, on: .main, in: .default)
        handler = timer.connect()
    }
    
    private func cancelTimer() {
        handler?.cancel()
    }
}

extension View {
    func onTimer(_ handler: Binding<Cancellable?>, every: TimeInterval, `repeat`: Bool = true, callback: @escaping (Cancellable) -> Void) -> some View {
        self.modifier(TimerViewModifier(handler, every: every, repeat: `repeat`, callback: callback))
    }
}

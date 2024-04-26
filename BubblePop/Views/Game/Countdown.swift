//
//  Countdown.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI
import Combine

struct StepConfig {
    let name: String
    let width: Double
    let height: Double
}

struct Countdown: View {
    @Binding var shouldCountdown: Bool
    
    private let steps: [StepConfig] = [
        StepConfig(name: "3", width: 100, height: 100),
        StepConfig(name: "2", width: 100, height: 100),
        StepConfig(name: "1", width: 100, height: 100),
        StepConfig(name: "GO", width: 200, height: 100)
    ]
    @State private var step: Int
    @State private var countdownHandler: Cancellable?
    @Inject private var soundPlayer: SoundPlayerService
    
    init(shouldCountdown: Binding<Bool>) {
        self._shouldCountdown = shouldCountdown
        self.step = 0
    }
    
    var body: some View {
        if step >= steps.count {
            EmptyView()
                .onChange(of: shouldCountdown) { prev, newValue in
                    if prev == false && newValue == true {
                        step = 0
                    }
                }
        } else {
            Image(steps[step].name)
                .resizable()
                .frame(width: steps[step].width, height: steps[step].height)
                .onTimer($countdownHandler, every: 1) { handler in
                    step += 1
                    if step >= steps.count {
                        shouldCountdown.toggle()
                        handler.cancel()
                    }
                }
                .onAppear {
                    soundPlayer.playSound(name: .countdown)
                }
        }
    }
}

#Preview {
    @State var shouldCountdown: Bool = true
    return Countdown(shouldCountdown: $shouldCountdown)
}

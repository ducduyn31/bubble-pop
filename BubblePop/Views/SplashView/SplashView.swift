//
//  SplashView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var systemState: SystemState
    
    // When everything is loaded, the loading screen will fade out
    private var shouldReverse: Binding<Bool> {
        Binding<Bool>(
            get: { systemState.state == .LoadComplete },
            set: { _ in }
        )
    }
    
    var body: some View {
        ZStack {
            Color("Base100")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Spacer()
                Logo()
                Spacer()
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                    HintText()
                }
            }
        }
        // Fade out once everything is loaded
        .reversibleFading(shouldReverse: shouldReverse, duration: 2, from: 0, to: 1)
        .onAppear {
            // Make sure all the credits are shown before fading out
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                systemState.publishEvent(event: .SplashScreenComplete)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(SystemState())
}

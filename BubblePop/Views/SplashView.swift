//
//  SplashView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 16/4/2024.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var systemState: SystemState
    
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
                Image("SplashIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
                    .blinking(from: 1, to: 0.5)
                Text("A product of Coffee with Egg")
                    .font(.title)
                    .colorScheme(.light)
            }
        }
        .reversibleFading(shouldReverse: shouldReverse, duration: 2, from: 0, to: 1)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                systemState.publishEvent(event: .SplashScreenComplete)
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(SystemState())
}

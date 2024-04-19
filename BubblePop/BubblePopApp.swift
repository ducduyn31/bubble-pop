//
//  BubblePopApp.swift
//  BubblePop
//
//  Created by Duy Nguyen on 15/4/2024.
//

import SwiftUI

@main
struct BubblePopApp: App {
    
    @StateObject private var systemState = SystemState()

    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color("Base100")
                    .ignoresSafeArea(.all, edges: .all)
                if systemState.state > .LoadComplete {
                    ContentView()
                } else {
                    SplashView()
                }
            }
            .task {
                DispatchQueue.global(qos: .background).async {
                    loadDependeciencies()
                    DispatchQueue.main.async {
                        systemState.publishEvent(event: .DIContainerReady)
                    }
                }
                DispatchQueue.global(qos: .background).async {
                    authenticatePlayer() { success in
                        guard success else { return }
                        DispatchQueue.main.async {
                            systemState.publishEvent(event: .GamekitIntegrationReady)
                        }
                    }
                }
                DispatchQueue.global(qos: .background).async {
                    configureSettings()
                    DispatchQueue.main.async {
                        systemState.publishEvent(event: .SettingsConfigured)
                    }
                }
            }
        }
        .environmentObject(systemState)
    }
}

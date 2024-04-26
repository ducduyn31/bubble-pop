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
                    ContentView() // Main content
                } else {
                    SplashView() // Loading screen
                        .alert(isPresented: systemState.isShowingAlert) {
                            // Alert for any error
                            Alert(
                                title: Text(systemState.currentAlert?.title ?? "Something went wrong"),
                                message: Text(systemState.currentAlert?.message ?? "An unknown error has occurred"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                }
            }
            // Load dependencies, resources, setting up authentication in the background
            .task {
                loadDependeciencies()
                systemState.publishEvent(event: .DIContainerReady)
                configureDefaultSettings()
                systemState.publishEvent(event: .SettingsConfigured)
                authenticatePlayer() { success in
                    guard success else {
                        systemState.publishEvent(event: .GamekitIntegrationFailed)
                        return
                    }
                    systemState.publishEvent(event: .GamekitIntegrationReady)
                }
            }
        }
        .environmentObject(systemState)
    }
}

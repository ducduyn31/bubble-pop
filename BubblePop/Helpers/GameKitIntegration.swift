//
//  GameKitIntegration.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import Foundation
import GameKit
import os

func authenticatePlayer(callback: @escaping (Bool) -> Void) {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: authenticatePlayer))
    GKLocalPlayer.local.authenticateHandler = { viewController, error in
        if let viewController = viewController {
            logger.info("Presenting Game Center login view controller")
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootViewController.present(viewController, animated: true)
            }
            return
        }
        if error != nil {
            logger.error("Failed to authenticate player: \(String(describing: error))")
            callback(false)
            return
        }
        logger.info("Player authenticated: \(GKLocalPlayer.local.isAuthenticated)")
        callback(true)
    }
}

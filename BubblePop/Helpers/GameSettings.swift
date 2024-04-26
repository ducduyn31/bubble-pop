//
//  GameSettings.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import Foundation

extension UserDefaults {
    func valueExists(forKey key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

/// Set default game mode if it is not set
func configureDefaultSettings() {
    if !UserDefaults.standard.valueExists(forKey: "gameMode") {
        UserDefaults.standard.setValue(1, forKey: "gameMode")
    }
}

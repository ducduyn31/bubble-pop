//
//  SoundPlayerService.swift
//  BubblePop
//
//  Created by Duy Nguyen on 25/4/2024.
//

import AVFoundation
import os

enum Sound: String, CaseIterable, Equatable, CustomStringConvertible {
    case bubblePop = "bubblePop.mp3"
    case gameOver = "gameOver.wav"
    case menuClick = "menuClick.wav"
    case backgroundLoop = "background.wav"
    case countdown = "go.wav"
    
    var description: String {
        return self.rawValue
    }
    
    static func == (lhs: Sound, rhs: String) -> Bool {
        return lhs.rawValue == rhs
    }
}

class SoundPlayerService {
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: SoundPlayerService.self))
    private var soundBuffer: [AVAudioPlayer] = []
    private var currentlyLoopped: [Sound: AVAudioPlayer] = [:]
    
    private func preloadSound(soundFileName: String) {
        guard let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: nil) else {
            logger.error("Failed to find sound file \(soundFileName)")
            return
        }
        
        let fileURL = URL(fileURLWithPath: bundlePath)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: fileURL)
            sound.prepareToPlay()
            soundBuffer.append(sound)
        } catch {
            logger.error("Failed to load sound file \(soundFileName)")
        }
    }
    
    func loadSounds() {
        Sound.allCases.forEach { preloadSound(soundFileName: $0.rawValue) }
        logger.info("\(self.soundBuffer.count) sounds loaded")
    }
    
    func playSound(name: Sound, isLooped: Bool = false) {
        guard let sound = soundBuffer.first(where: { $0.url?.lastPathComponent == name.rawValue }) else {
            logger.error("Failed to find sound file \(name)")
            return
        }
        
        if isLooped {
            sound.numberOfLoops = -1
            sound.play()
            currentlyLoopped[name] = sound
        } else {
            sound.play()
        }
    }
    
    func stopSound(name: Sound) {
        guard let sound = currentlyLoopped[name] else {
            logger.error("Failed to find sound file \(name)")
            return
        }
        
        sound.stop()
        sound.currentTime = 0
        currentlyLoopped.removeValue(forKey: name)
    }
}

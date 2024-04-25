//
//  DependencyInjection.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import os



func loadDependeciencies() {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: loadDependeciencies))
    Container.shared.autoregister(BubbleFactory.self, initializer: BubbleFactory.init).inObjectScope(.container)
    Container.shared.autoregister(GameFactory.self, initializer: GameFactory.init).inObjectScope(.container)
    Container.shared.autoregister(GameSessionService.self, initializer: GameSessionService.init).inObjectScope(.container)
    Container.shared.autoregister(IBubbleGenerateStrategy.self, initializer: MediumBubbleGenerateStrategy.init).inObjectScope(.container)
    Container.shared.autoregister(IBubbleDegenerateStrategy.self, initializer: MediumBubbleDegenerateStrategy.init).inObjectScope(.container)
    Container.shared.autoregister(SoundPlayerService.self, initializer: SoundPlayerService.init).inObjectScope(.container)
//    Container.shared.register([IBubbleGenerateStrategy].self) { r in
//        [
////            r.resolve(IBubbleGenerateStrategy.self, name: "easyLevel")!,
//            r.resolve(IBubbleGenerateStrategy.self, name: "mediumGenLevel")!,
////            r.resolve(IBubbleGenerateStrategy.self, name: "hardLevel")!
//        ]
//    }
//    Container.shared.register([IBubbleDegenerateStrategy].self) { r in
//        [
////            r.resolve(IBubbleGenerateStrategy.self, name: "easyLevel")!,
//            r.resolve(IBubbleDegenerateStrategy.self, name: "mediumDegLevel")!,
////            r.resolve(IBubbleGenerateStrategy.self, name: "hardLevel")!
//        ]
//    }
    
    loadSounds()
    logger.info("Dependencies loaded")
}

fileprivate func loadSounds() {
    let soundService = Container.shared.resolve(SoundPlayerService.self)
    soundService?.loadSounds()
}


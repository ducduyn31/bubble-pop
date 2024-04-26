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


/// Make sure the following class is initialize once using DI architecture
func loadDependeciencies() {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: loadDependeciencies))
    // Load factory files
    Container.shared.autoregister(BubbleFactory.self, initializer: BubbleFactory.init).inObjectScope(.container)
    Container.shared.autoregister(GameFactory.self, initializer: GameFactory.init).inObjectScope(.container)
    
    // Load game services
    Container.shared.autoregister(GameSessionService.self, initializer: GameSessionService.init).inObjectScope(.container)
    Container.shared.autoregister(SoundPlayerService.self, initializer: SoundPlayerService.init).inObjectScope(.container)
    
    // Load strategies, when more strategies are introduced, this is the place to load them,
    // This is very similar to how Spring Boot DI works under the hood. If multiple strategies
    // is provided, we can use `@Inject strategies: [IBubbleGenerateStrategy]` to get all the
    // strategies. If not the default strategy will be used
    Container.shared.autoregister(IBubbleGenerateStrategy.self, initializer: MediumBubbleGenerateStrategy.init).inObjectScope(.container)
    Container.shared.autoregister(IBubbleDegenerateStrategy.self, initializer: MediumBubbleDegenerateStrategy.init).inObjectScope(.container)
    
    // Load sounds once sound service is loaded
    loadSounds()
    logger.info("Dependencies loaded")
}

fileprivate func loadSounds() {
    let soundService = Container.shared.resolve(SoundPlayerService.self)
    soundService?.loadSounds()
}


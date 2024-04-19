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
    // Simulate loading by sleeping for 30 seconds
    Container.shared.autoregister(BubbleFactory.self, initializer: BubbleFactory.init)
    Container.shared.autoregister(GameFactory.self, initializer: GameFactory.init)
    Container.shared.autoregister(GameSessionService.self, initializer: GameSessionService.init)
    Container.shared.autoregister(IBubbleGenerateStrategy.self, initializer: MediumBubbleGenerateStrategy.init)
    Container.shared.autoregister(IBubbleDegenerateStrategy.self, initializer: MediumBubbleDegenerateStrategy.init)
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
    logger.info("Dependencies loaded")
}

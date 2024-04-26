//
//  Container+Extensions.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import Foundation
import Swinject

/// Container for dependency injection
extension Container {
    static let shared = Container()
    
    subscript<Service>(_ serviceType: Service.Type) -> Service {
        get {
            return resolve(serviceType)!
        }
    }
}

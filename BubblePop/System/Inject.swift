//
//  Inject.swift
//  BubblePop
//
//  Created by Duy Nguyen on 17/4/2024.
//

import Foundation
import Swinject

@propertyWrapper
struct Inject<Service> {
    private let name: String?
    
    init(_ name: String? = nil) {
        self.name = name
    }
    
    var wrappedValue: Service {
        get {
            let resolvedService = Container.shared.resolve(Service.self, name: name)
            assert(resolvedService != nil, "Service \(String(describing: Service.self)) not registered")
            return resolvedService!
        }
    }
}

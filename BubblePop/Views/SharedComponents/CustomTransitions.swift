//
//  CustomTransitions.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import SwiftUI

extension AnyTransition {
    static var customTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing).combined(with: .opacity)
        let removal = AnyTransition.scale.combined(with: .opacity)
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

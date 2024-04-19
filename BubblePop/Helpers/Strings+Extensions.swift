//
//  Strings+Extensions.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import Foundation

extension String {
    func or(_ newValue: String) -> String {
        return self.isEmpty ? newValue : self
    }
}

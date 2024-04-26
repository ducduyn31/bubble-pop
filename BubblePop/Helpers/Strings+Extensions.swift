//
//  Strings+Extensions.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import Foundation

extension String {
    /// Check if a string is empty or nil, return a default value if it is
    func or(_ newValue: String) -> String {
        return self.isEmpty ? newValue : self
    }
    
    /// Limit the number of characters in a string, if the string is a number, format it to K, M, B, T
    func clamp(maxChars: Int) -> String {
        if let _ = Double(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 1
            
            let names = ["", "K", "M", "B", "T"]
            var level = 0
            var num = Double(self)!
            
            while num >= 1000 && level < names.count - 1 {
                num /= 1000
                level += 1
            }
            
            return "\(numberFormatter.string(for: num) ?? "")\(names[level])"
        }
        
        if self.count > maxChars {
            return String(self.prefix(maxChars)) + "..."
        }
        
        return self
    }
}

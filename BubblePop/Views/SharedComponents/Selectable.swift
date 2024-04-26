//
//  Selectable.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import SwiftUI

/// A view modifier that makes the view selectable
/// When the view is selected, it will grow in size
/// When the view is deselected, it will shrink back to its original size
struct SelectableViewMod: ViewModifier {
    let initialWidth: Double
    let initialHeight: Double
    private let isSelected: Bool
    
    init(_ isSelected: Bool, initialWidth: Double, initialHeight: Double) {
        self.initialWidth = initialWidth
        self.initialHeight = initialHeight
        self.isSelected = isSelected
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: isSelected ? initialWidth * 1.2 : initialWidth, height: isSelected ? initialHeight * 1.2 : initialHeight)
    }
}

extension View {
    func selectable(_ isSelected: Bool, initialWidth: Double = 200, initialHeight: Double = 100) -> some View {
        self.modifier(SelectableViewMod(isSelected, initialWidth: initialWidth, initialHeight: initialHeight))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isSelected = false
        
        var body: some View {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isSelected.toggle()
                }
            }) {
                Text("Click")
            }
            .selectable(isSelected)
            .background(Color("Base200"))
        }
    }
    
    return PreviewWrapper()
}

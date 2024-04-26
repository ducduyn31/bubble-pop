//
//  Card.swift
//  BubblePop
//
//  Created by Duy Nguyen on 19/4/2024.
//

import SwiftUI

/// A card view with a background color
struct Card<Content: View>: View {
    let content: Content
    var color: Color
    
    init(_ backgroundColor: Color? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.color = backgroundColor ?? Color("Base100")
    }
    
    var body: some View {
        content
        .padding()
        .background(color)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    Card(.red) {
        Text("Hello, World!")
    }
    .frame(width: 500, height: 100)
}

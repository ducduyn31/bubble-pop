//
//  ContentView.swift
//  BubblePop
//
//  Created by Duy Nguyen on 15/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            GameMenuView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    loadDependeciencies()
    return ContentView()
}

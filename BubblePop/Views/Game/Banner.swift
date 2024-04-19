//
//  Banner.swift
//  BubblePop
//
//  Created by Duy Nguyen on 18/4/2024.
//

import SwiftUI

struct Banner: View {
    var time: Int
    var score: Int
    var highscore: Int
    
    var body: some View {
        Grid(verticalSpacing: -10) {
            GridRow {
                Text("Time")
                    .font(.title)
                    .padding()
                Text("Score")
                    .font(.title)
                    .padding()
                Text("Highscore")
                    .font(.title)
                    .padding()
            }
            Color.gray.frame(height: 0)
            GridRow {
                Text("\(time)")
                    .font(.title)
                    .padding()
                Text("\(score)")
                    .font(.title)
                    .padding()
                Text("\(highscore)")
                    .font(.title)
                    .padding()
            }
        }
    }
}

#Preview {
    Banner(time: 60, score: 0, highscore: 0)
}

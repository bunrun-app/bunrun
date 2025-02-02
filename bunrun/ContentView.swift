//
//  ContentView.swift
//  bunrun
//
//  Created by dorin flocos on 1/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            Text("bunrun")
                .fontWeight(.bold)
                .font(.largeTitle)

            OrderView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

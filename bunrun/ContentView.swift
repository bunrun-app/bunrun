//
//  ContentView.swift
//  bunrun
//
//  Created by dorin flocos on 1/30/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var session: Session

    var body: some View {
        VStack {
            if session.status != .authenticated {
                AuthView()
            } else {
                OrderView()
            }
        }
        .onAppear {
            session.validate()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Session())
}

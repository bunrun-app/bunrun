//
//  OrderView.swift
//  bunrun
//
//  Created by dorin flocos on 2/1/25.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var session: Session
    @State var viewModel = OrderViewModel()

    @State private var orderDetails: String = ""

    var body: some View {
        ZStack {
            Button(action: {
                session.invalidate()
            }) {
                Text("Sign out")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)

            VStack {
                TextField("What would you like to order?", text: $orderDetails, axis: .vertical)
                    .lineLimit(4...10)
                    .textFieldStyle(.roundedBorder)

                Button {
                    viewModel.submitOrder(details: orderDetails)
                    orderDetails = ""
                } label: {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Session())
}

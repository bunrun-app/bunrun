//
//  OrderView.swift
//  bunrun
//
//  Created by dorin flocos on 2/1/25.
//

import SwiftUI

struct OrderView: View {
    @State var viewModel = OrderViewModel()

    @State var orderDetails: String = ""

    var body: some View {
        VStack {
            TextField("What would you like to order?", text: $orderDetails, axis: .vertical)
                .lineLimit(2...10)
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
    }
}

#Preview {
    ContentView()
}

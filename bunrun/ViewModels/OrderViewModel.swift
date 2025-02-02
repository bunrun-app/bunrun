//
//  OrderViewModel.swift
//  bunrun
//
//  Created by dorin flocos on 2/1/25.
//

import FirebaseFirestore

@Observable
class OrderViewModel {
    var order: Order?

    init() {}

    private let db = Firestore.firestore()

    func submitOrder(details: String) {
        if (!details.isEmpty) {
            let order = Order(details: details)

            do {
                _ = try db.collection("orders").addDocument(from: order)
            } catch {
                print("Error adding task: \(error.localizedDescription)")
            }
        }
    }
}

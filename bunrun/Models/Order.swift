//
//  Order.swift
//  bunrun
//
//  Created by dorin flocos on 2/1/25.
//

import FirebaseFirestore

struct Order: Identifiable, Codable {
    @DocumentID var id: String?
    let details: String
}

//
//  User.swift
//  bunrun
//
//  Created by dorin flocos on 2/6/25.
//

import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let email: String
    let fcmToken: String?
    let createdAt: Timestamp
}

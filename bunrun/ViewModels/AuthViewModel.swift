//
//  AuthViewModel.swift
//  bunrun
//
//  Created by dorin flocos on 2/6/25.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseMessaging

@Observable
class AuthViewModel {
    func signInUser(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, "Failed to create user: \(error.localizedDescription)")
            } else {
                completion(true, nil)
            }
        }
    }

    func signUpUser(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false, "Failed to create user: \(error.localizedDescription)")
                return
            }

            guard let user = authResult?.user else {
                completion(false, "Failed to get user data")
                return
            }

            Messaging.messaging().token { [weak self] token, error in
                if let error = error {
                    completion(false, "Failed to get FCM token: \(error.localizedDescription)")
                    return
                }

                guard let fcmToken = token else {
                    completion(false, "Failed to get FCM token")
                    return
                }

                self?.saveUserData(userID: user.uid, firstName: firstName, lastName: lastName, email: email, fcmToken: fcmToken) { success, error in
                    completion(success, success ? nil : "Failed to save user data: \(error!)")
                }
            }
        }
    }

    func saveUserData(userID: String, firstName: String, lastName: String, email: String, fcmToken: String, completion: @escaping (Bool, String?) -> Void) {
        let db = Firestore.firestore()
        let user = User(firstName: firstName, lastName: lastName, email: email, fcmToken: fcmToken, createdAt: Timestamp())

        do {
            _ = try db.collection("users").document(userID).setData(from: user)
            completion(true, nil)
        } catch {
            completion(false, error.localizedDescription)
        }
    }
}

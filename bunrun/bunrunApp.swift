//
//  bunrunApp.swift
//  bunrun
//
//  Created by dorin flocos on 1/30/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import UserNotifications

class Session: ObservableObject {
    enum Status: String {
        case unauthenticated
        case authenticated
        case loading
    }

    @Published public var status: Status
    @Published public var user: FirebaseAuth.User?

    init() {
        self.status = .unauthenticated
    }

    func validate() {
        if let currentUser = Auth.auth().currentUser {
            self.user = currentUser
            self.status = .authenticated
        } else {
            self.status = .unauthenticated
        }
    }

    func invalidate() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }

        self.user = nil
        self.status = .unauthenticated
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self

            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { granted, error in
                print("Permission granted: \(granted)")
            })
            Messaging.messaging().delegate = self

            application.registerForRemoteNotifications()
        }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([[.banner, .list, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil, userInfo: userInfo)
        completionHandler()
    }

    @objc func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase token: \(String(describing: fcmToken))")
    }
}

@main
struct bunrunApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var session = Session()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}

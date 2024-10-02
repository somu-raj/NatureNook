import Flutter
import UIKit
import FirebaseCore
import FirebaseMessaging
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Register for push notifications
    UNUserNotificationCenter.current().delegate = self

    // Initialize Firebase
    FirebaseApp.configure()

    // Set plugin registrant callback for Flutter local notifications
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
        GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      // Set APNs token for Firebase Messaging
      Messaging.messaging().apnsToken = deviceToken
      super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
}
}

//
//
// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
// // FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// class LocalNotificationService {
//   /* static final FlutterLocalNotificationsPlugin
//   _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();*/
//
//    void initialize() async {
//     NotificationSettings settings =
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//    if( settings.authorizationStatus == AuthorizationStatus.denied){
//       return;
//     }
//    else if (settings.authorizationStatus == AuthorizationStatus.provisional){
//      const InitializationSettings initializationSettings =
//      InitializationSettings(
//          android: AndroidInitializationSettings(
//              "@mipmap/ic_launcher"),
//          //DrawInitializationSettings
//          iOS: DarwinInitializationSettings());
//      flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//      await FirebaseMessaging.instance
//          .setForegroundNotificationPresentationOptions(
//        alert: true, // Required to display a heads up notification
//        badge: true,
//        sound: true,
//      );
//
//      const AndroidNotificationChannel channel = AndroidNotificationChannel(
//        'high_importance_channel', // id
//        'High Importance Notifications', // title
//        description: 'This channel is used for important notifications.', // description
//        importance: Importance.max,sound: RawResourceAndroidNotificationSound('test'),playSound: true,showBadge: true,
//      );
//      await flutterLocalNotificationsPlugin
//          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//          ?.createNotificationChannel(channel);
//
//      FirebaseMessaging.instance.getInitialMessage().then(
//            (message) {
//          log("FirebaseMessaging.instance.getInitialMessage");
//          if (message != null) {
//            log("New Notification");
//            // if (message.data['_id'] != null) {
//            //   Navigator.of(context).push(
//            //     MaterialPageRoute(
//            //       builder: (context) => DemoScreen(
//            //         id: message.data['_id'],
//            //       ),
//            //     ),
//            //   );
//            // }.
//            display(message);
//          }
//        },
//      );
//
//      FirebaseMessaging.onMessage.listen(
//            (message) {
//          log("FirebaseMessaging.onMessage.listen");
//          if (message.notification != null) {
//            log(message.notification!.title);
//            log(message.notification!.body);
//            log("message.data11 ${message.data['channel_id']}");
//
//            if(message.data['channel_id']!=null && message.data['call_id']!= null) {
//
//
//            }
//
//
//            display(message);
//          }
//        },
//      );
//
//      FirebaseMessaging.onMessageOpenedApp.listen(
//            (message) {
//          log("FirebaseMessaging.onMessageOpenedApp.listen");
//          if (message.notification != null) {
//            log(message.notification!.body);
//            log(message.notification!.body);
//
//            if(message.data['channel_id']!=null && message.data['call_id']!= null) {
//
//
//
//
//            }
//          }
//        },
//      );
//    }
//
//   }
//
//   Future<String?>getToken() async {
//      String? token = await FirebaseMessaging.instance.getToken();
//      return token;
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       log("In Notification method");
//       // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
//       Random random = Random();
//       int id = random.nextInt(1000);
//       const NotificationDetails notificationDetails = NotificationDetails(
//           android: AndroidNotificationDetails(
//             "default_notification_channel",
//             "jewellery_channel",
//             importance: Importance.max,
//             priority: Priority.high,
//             playSound:true,
//             // icon: 'ic_launcher',
//             sound: RawResourceAndroidNotificationSound('test'),
//           ));
//       log("my id is ${id.toString()}");
//
//       await flutterLocalNotificationsPlugin.show(
//           id,
//           message.notification!.title,
//           message.notification!.body,
//           notificationDetails,
//           payload: message.data['_id']);
//     } on Exception catch (e) {
//       log('Error>>>$e');
//     }
//   }
//
// }
//
//

// Dart imports:
import 'dart:developer';
import 'dart:math' hide log;

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService() {
    _initialize();
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"),
            iOS: DarwinInitializationSettings());

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.instance.getInitialMessage().then(
        (message) {
          log("FirebaseMessaging.instance.getInitialMessage");
          if (message != null) {
            log("New Notification");
          }
        },
      );
      FirebaseMessaging.onMessage.listen(
        (message) {
          log("FirebaseMessaging.onMessage______________");
          if (message.notification != null) {
            log('${message.notification!.body}_________body____');
            log("message.data11 ${message.data}");
            display(message);
            //handleNotification(message.data);
          }
        },
      );

      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          log("FirebaseMessaging.onMessageOpenedApp___________");
          if (message.notification != null) {
            log('_____________${message.notification}_______________');
            log('_____________${message.notification?.title}_______________');
            log(message.notification!.body.toString());
            log("message.data22 ${message.data}");

            //handleNotification(message.data);

            // HomeScreenState().setSegmentValue(2) ;
          }
        },
      );
    }
  }

  Future<void> handleNotification(Map<String, dynamic> message) async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // App was opened from a notification
      // TODO: handle the notification
    } else {
      // App was opened normally
    }
  }

  void display(RemoteMessage message) async {
    try {
      log("In Notification method");
      Random random = Random();
      int id = random.nextInt(1000);
      log("my id is ${id.toString()}");

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "Nature_channel_id",
            "Nature_Nook_Mart",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails());
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data['_id']);
    } on Exception catch (e) {
      log('Error>>>$e');
    }
  }
}

/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    // Initialization Settings for Android
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialization Settings for iOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _localNotificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    // Handle iOS foreground notification.
  }

  static void onSelectNotification(NotificationResponse response) async {
    // Handle notification tap.
  }

  static Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    final iOSDetails = DarwinNotificationDetails();

    final platformDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await _localNotificationPlugin.show(
      0, // Notification ID (must be unique)
      notification?.title,
      notification?.body,
      platformDetails,
    );
  }

  static Future<void> requestNotificationPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (Platform.isIOS) {
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}
*/
///
/*import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  static Future<void> initialize() async {
    // Request permission for notifications
    LocalNotificationService.requestNotificationPermissions();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.showNotification(message);
      }
    });

    // Handle notification tap when the app is in background or terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the notification click event
    });

    // Get the FCM token for the device
    String? token = await messaging.getToken();
    print('FCM Token: $token');
  }
}
*/

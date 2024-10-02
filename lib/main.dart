// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Network%20Connectivity/connectivty_check.dart';
import 'package:nature_nook_app/Screens/splash/splash_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/notification_services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NetworkConnectivityService();
  await SharedPref.getInstance();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  log("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Constants.getScreenSize(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NatureNook App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: NatureColor.primary1),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: NatureColor.blackColor,
          displayColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
// Dart imports:

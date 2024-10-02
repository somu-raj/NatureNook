// File generated by FlutterFire CLI.
// ignore_for_file: type=lint

// Package imports:
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD8pex4E8MHLhjeCN6t4MOcwDFABU1yr7k',
    appId: '1:83467907411:web:c832f48193878789aab1a6',
    messagingSenderId: '83467907411',
    projectId: 'naturenookmart',
    authDomain: 'naturenookmart.firebaseapp.com',
    storageBucket: 'naturenookmart.appspot.com',
    measurementId: 'G-1SLFZPT396',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-WexsdVT09nYRxYclwoUoJ-pLiexpXig',
    appId: '1:83467907411:android:062b5a39c1182abeaab1a6',
    messagingSenderId: '83467907411',
    projectId: 'naturenookmart',
    storageBucket: 'naturenookmart.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4t_VLTxoZmY7n3n_3M9cmZqm7TjkdkTA',
    appId: '1:83467907411:ios:5284488e145a538caab1a6',
    messagingSenderId: '83467907411',
    projectId: 'naturenookmart',
    storageBucket: 'naturenookmart.appspot.com',
    iosBundleId: 'nature-nook-app.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4t_VLTxoZmY7n3n_3M9cmZqm7TjkdkTA',
    appId: '1:83467907411:ios:eb404c3ed647010baab1a6',
    messagingSenderId: '83467907411',
    projectId: 'naturenookmart',
    storageBucket: 'naturenookmart.appspot.com',
    iosBundleId: 'naturenook-mac.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8pex4E8MHLhjeCN6t4MOcwDFABU1yr7k',
    appId: '1:83467907411:web:faf5ed684ce072bdaab1a6',
    messagingSenderId: '83467907411',
    projectId: 'naturenookmart',
    authDomain: 'naturenookmart.firebaseapp.com',
    storageBucket: 'naturenookmart.appspot.com',
    measurementId: 'G-NFXDLW01M5',
  );
}

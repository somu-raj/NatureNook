// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Screens/Intro Screen/intro_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      goToStartScreen();
    });
  }

  goToStartScreen() {
    bool firstTime = SharedPref.getFirstTime();
    if (firstTime) {
      Get.to(() => const IntroScreen());
    } else {
      // bool loggedIn = SharedPref.getLogin();
      // if (!loggedIn) {
      //   Get.to(() => const LoginScreen());
      // } else {
      Get.to(() => const DashboardScreen(selectedIndex: 0));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/splash.jpg',
        fit: BoxFit.fill,
      ),
    ));
  }
}

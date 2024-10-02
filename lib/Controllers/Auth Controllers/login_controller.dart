// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api%20Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api%20Services/api_services.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Screens/auth/Registration/registration_screen.dart';
import 'package:nature_nook_app/Screens/auth/Registration/verify_otp.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

import '../../Screens/auth/Forget Password/confirm_otp_screen.dart';

class LoginController extends GetxController {
  RxBool passwordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;

  ///api urls
  String get loginUrl => ApiServices().login;
  String get verifyNewUrl => ApiServices().verifyNewUser;
  String get verifyOtpUrl => ApiServices().verifyOtp;
  String get forgotPassword => ApiServices().forgotPassword;
  String _fcmToken = '';
  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final verifyMobileController = TextEditingController();
  final passwordController = TextEditingController();
  final forgetPassMobileController = TextEditingController();
  final _messaging = FirebaseMessaging.instance;

  Future<void> getFCMToken() async {
    _fcmToken = await _messaging.getToken() ?? "";
    log('fcm token -->$_fcmToken');
  }

  ///on controller close
  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  /// login method on submit
  Future<dynamic> login() async {
    if (mobileController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Mobile Number Not Found",
          msg: 'Please Enter mobile number',
          maxWidth: 300);
    } else if (passwordController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Password Not Found",
          msg: 'Please Enter Password',
          maxWidth: 300);
    } else {
      getLogin();
    }
  }

  ///  api request for login
  getLogin() async {
    isLoading.value = true;
    await getFCMToken();
    await ApiBaseHelper().postAPICall(Uri.parse(loginUrl), {
      "mobile": mobileController.text,
      "password": passwordController.text,
      'fcm_id': _fcmToken,
    }).then((value) {
      log("value --> $value");
      isLoading.value = false;
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        SharedPref.setLoginAndUserId(value['data'][0]['id']);
        Get.to(() => const DashboardScreen(
              selectedIndex: 0,
            ));
        Get.delete<LoginController>();
      }
    }, onError: (error) {
      isLoading.value = false;
    });
  }

  ///  api request for verify mobile
  verifyRegisterMobile() async {
    if (verifyMobileController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Mobile number not found",
          msg: "Please enter mobile number to verify");
      return;
    }
    Utils.showLoader();
    await ApiBaseHelper().postAPICall(Uri.parse(verifyNewUrl), {
      "mobile": verifyMobileController.text,
    }).then((value) {
      Get.back();
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
        print("this is  a otp---->${value["data"]}");
      } else {
          Get.to(() => VerifyOtpScreen(mobileNumber: verifyMobileController.text));
      }
    }, onError: (error) {
      Get.back();
    });
  }


  ///  api request for forgot mobile

  verifyForgotMobile() async {
    if (forgetPassMobileController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Mobile number not found",
          msg: "Please enter mobile number to verify");
      return;
    }
    Utils.showLoader();
    await ApiBaseHelper().postAPICall(Uri.parse(forgotPassword), {
      "mobile": forgetPassMobileController.text,
    }).then((value) {
      Get.back();
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        var otp = value['data'];
          Get.to(() => ConfirmOtpScreen(otp:otp.toString() ,mobile: forgetPassMobileController.text));
      }
    }, onError: (error) {
      Get.back();
    });
  }

  ///  api request for verify otp
  verifyOtp(String otp) async {
    if (otp.isEmpty || otp.length != 4) {
      Utils.mySnackBar(
          title: "Otp not  found", msg: "Please enter otp to verify");
      return;
    }
    Utils.showLoader();
    await ApiBaseHelper().postAPICall(Uri.parse(verifyOtpUrl), {
      "mobile": verifyMobileController.text,
      "otp":otp,
    }).then((value) {
      Get.close(3);
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        Get.to(() => RegistrationScreen(
              mobileNumber: verifyMobileController.text,
            ));
      }
    }, onError: (error) {
      Get.back();
    });
  }

  //Forget Pass word handling
  /// handle verify email and send confirmation code method and get back to the login screen
  Future<bool> verifyMobileAndSendCode({bool forget = false}) async {
    if (forget && forgetPassMobileController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Mobile Not Found",
          msg: 'Please Enter mobile no.',
          maxWidth: 200);
      return false;
    } else if (!forget && verifyMobileController.text.isEmpty) {
      Utils.mySnackBar(
          title: "Mobile Not Found",
          msg: 'Please Enter mobile no.',
          maxWidth: 200);
      return false;
    } else {
      isLoading.value = true;
      // await apiRequests.userLogin(
      //   mobileController.text,
      //   passwordController.text,
      //   audioController,
      // );
      Get.back();
      isLoading.value = false;
      return true;
    }
  }
}

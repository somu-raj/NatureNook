// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class RegistrationController extends GetxController {
  var passwordVisible = false.obs;
  var isLoading = false.obs;
  String _fcmToken = '';
  final _messaging = FirebaseMessaging.instance;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  // final phoneController = TextEditingController();
  final referralController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get registerUrl => ApiServices().registerNewUser;

  Future<void> getFCMToken() async {
    _fcmToken = await _messaging.getToken() ?? "";
    log('fcm token -->$_fcmToken');
  }

  ///on controller close
  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    referralController.dispose();
    super.onClose();
  }

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  getRegister(String mobile) async {
    await getFCMToken();
    isLoading.value = true;
    Map<String, String> param = {
      "name": nameController.text,
      "email": emailController.text,
      "mobile": mobile,
      "friends_code":referralController.text,
      /*"dob": "",
      "city": "",
      "area": "",
      "street": "",
      "pincode": "",
      "referral_code": "",
      "friends_code": "",
      "latitude": "",
      "longitude": "",*/
      "fcm_id": _fcmToken,
      "password": passwordController.text,
      "country_code": "+91"
    };
    await ApiBaseHelper().postAPICall(Uri.parse(registerUrl), param).then(
        (value) {
      log("value --> $value");
      isLoading.value = false;
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        SharedPref.setLoginAndUserId(value['data'][0]['id']);
        passwordController.clear();
        emailController.clear();
        nameController.clear();
        referralController.clear();
        Get.to(() => const DashboardScreen(
              selectedIndex: 0,
            ));
        Get.delete<RegistrationController>();
      }
    }, onError: (error) {
      isLoading.value = false;
    });
  }

  /// register user method on Sign up
  Future<void> register(String mobile) async {
    if (formKey.currentState!.validate()) {
      getRegister(mobile);
    }
  }

// void _validateAndSubmit() {
//   if (emailC.text.isEmpty) {
//     CustomSnackbar.show(context, 'Please Enter Email Address');
//     return;
//   }
//
//   if (passwordC.text.isEmpty) {
//     CustomSnackbar.show(context, 'Please Enter Password');
//     return;
//   }
//
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (context) => const RegistrationScreen()),
//   );
// }
}

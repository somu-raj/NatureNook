// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class ResetPasswordController extends GetxController {
  var oldPasswordVisible = false.obs;
  var newPasswordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// get user id
  final String _userId = SharedPref.getUserId();

  ///on controller close
  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  ///handle password visibility
  void toggleOldPasswordVisibility() {
    oldPasswordVisible.value = !oldPasswordVisible.value;
  }

  ///handle password visibility
  void togglePasswordVisibility() {
    newPasswordVisible.value = !newPasswordVisible.value;
  }

  ///handle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  String get passwordChangeUrl => ApiServices().changePassword;
  String get resetPasswordUrl => ApiServices().resetPassword;

  ///  api request for password
  Future<bool> updatePassword() async {
    Utils.showLoader();
    bool updated = false;
    await ApiBaseHelper().postAPICall(Uri.parse(passwordChangeUrl), {
      'user_id': _userId,
      "password": oldPasswordController.text,
      "new_password": newPasswordController.text
    }).then((value) {
      Get.back();
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
        updated = false;
      } else {
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        updated = true;
      }
    }, onError: (error) {
      Get.back();
      updated = false;
    });
    return updated;
  }


  Future<bool> resetPassword(String mobile) async {
    Utils.showLoader();
    bool updated = false;
    await ApiBaseHelper().postAPICall(Uri.parse(resetPasswordUrl), {
      "mobile":mobile.toString(),
      "new_password": newPasswordController.text
    }).then((value) {
      Get.back();
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
        updated = false;
      } else {
        newPasswordController.clear();
        updated = true;
      }
    }, onError: (error) {
      Get.back();
      updated = false;
    });
    return updated;
  }

  /// register user method on Sign up
  Future<void> verifyAccount() async {
    if (formKey.currentState!.validate()) {}
  }
}

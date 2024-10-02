// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
import 'package:nature_nook_app/Network%20Connectivity/connectivty_check.dart';
import 'package:nature_nook_app/color/colors.dart';

class Utils {
  static void mySnackBar({
    String title = "",
    String msg = "",
    double? maxWidth,
    String? buttonText,
    VoidCallback? onTap,
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    Get.snackbar(
      title,
      msg,
      mainButton: TextButton(onPressed: onTap, child: Text(buttonText??'',/*style: const TextStyle(color: Colors.yellow)*/)),
      maxWidth: maxWidth,
      animationDuration: const Duration(milliseconds: 900),
      duration: duration,
      borderColor: NatureColor.primary,
      borderWidth: 1,
      colorText: NatureColor.blackColor,
      backgroundColor: NatureColor.whiteTemp,
      boxShadows: [
        const BoxShadow(
          color: NatureColor.primary2,
          blurRadius: 3,
          spreadRadius: 1,
        ),
      ],
      titleText: title == "" ? const SizedBox() : null,
      messageText: msg == '' ? const SizedBox() : null,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
    );
  }

  static Future<bool> showConfirmDialog(
      String title, String contentText) async {
    bool? result = await Get.defaultDialog(
        title: title,
        content: CustomText(
          text: contentText,
          fontSize: 4.5,
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          child: const Text('No'),
        ),
        confirm: TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: NatureColor.primary,
          ),
          child: const Text('Yes'),
        ));
    if (result != null) {
      return result;
    }
    return false;
    // showDialog(
    //
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15),
    //       ),
    //       title: const Row(
    //         children: [
    //           SizedBox(width: 10),
    //           Text('Logout '),
    //         ],
    //       ),
    //       content: const Text('Do you want to logout?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             // Perform logout operation here
    //             Navigator.of(context).pop(); // Close the dialog
    //           },
    //           style: TextButton.styleFrom(
    //             foregroundColor: Colors.white,
    //             backgroundColor: Colors.red,
    //           ),
    //           child: const Text('No'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             SharedPref.setLogOut();
    //             Get.to(()=>const LoginScreen());
    //           },
    //           style: TextButton.styleFrom(
    //             foregroundColor: Colors.white,
    //             backgroundColor: NatureColor.primary,
    //           ),
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  static Future<void> showLoader() async {
    Get.dialog(
      barrierDismissible: false,
      PopScope(
        canPop: !(await NetworkConnectivityService.checkInternetConnection()),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: NatureColor.whiteTemp,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: NatureColor.primary1,
                    blurRadius: 1,
                    spreadRadius: 2,
                  )
                ]),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

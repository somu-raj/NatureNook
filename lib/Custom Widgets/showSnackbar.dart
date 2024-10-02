// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/color/colors.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: NatureColor.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

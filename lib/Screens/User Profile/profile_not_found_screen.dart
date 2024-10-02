// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart Controller/cart_controller.dart';
import 'package:nature_nook_app/Controllers/Category Controller/category_controller.dart';
import 'package:nature_nook_app/Controllers/Home Controller/home_controller.dart';
import 'package:nature_nook_app/Controllers/Profile Controller/Update Controller/profile_update_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ProfileNotFound extends StatelessWidget {
  const ProfileNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32,
          ),
          Image.asset(
            "assets/images/profile_not_found.png",
            height: Constants.largeSize * 0.3,
          ),
          const SizedBox(
            height: 32,
          ),
          const CustomText(
            text: 'Not Signed In',
            fontSize: 6,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 8,
          ),
          const CustomText(
            text: "Please sign in or\nregister a new account",
            fontSize: 4.5,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                text: "SignIn/Register",
                onPressed: () {
                  Get.to(() => const LoginScreen(
                        canPop: true,
                      ));
                  Get.delete<HomeController>();
                  Get.delete<CartController>();
                  Get.delete<CategoryController>();
                  Get.delete<ProfileController>();
                }),
          ),
        ],
      ),
    );
  }
}

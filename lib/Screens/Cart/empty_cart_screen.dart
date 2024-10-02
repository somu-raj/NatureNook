// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart%20Controller/cart_controller.dart';
import 'package:nature_nook_app/Controllers/Category%20Controller/category_controller.dart';
import 'package:nature_nook_app/Controllers/Home%20Controller/home_controller.dart';
import 'package:nature_nook_app/Controllers/Profile%20Controller/Update%20Controller/profile_update_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/constants/constants.dart';

class EmptyCartScreen extends StatelessWidget {
  final bool signIn;
  const EmptyCartScreen({super.key, required this.signIn});

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
            "assets/images/empty_cart.png",
            height: Constants.largeSize * 0.3,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomText(
            text: signIn ? "Your Cart Is Empty" : 'No Account Found',
            fontSize: 6,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomText(
            text: signIn
                ? "Looking like you haven't added anything\nTo your cart yet"
                : "Looking like you haven't sign in yet\nPLease sign in to get cart products",
            fontSize: 4.5,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32,
          ),
          if (!signIn)
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
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

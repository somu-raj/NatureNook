// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  NatureColor.scaffoldBackGround,
                  NatureColor.scaffoldBackGround1,
                  NatureColor.scaffoldBackGround1,
                  NatureColor.scaffoldBackGround1,
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/order_success.png",
                  height: Constants.largeSize * 0.3,
                ),
                const SizedBox(
                  height: 32,
                ),
                const CustomText(
                  text: "Order Placed Successfully!",
                  fontSize: 6,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 8,
                ),
                const CustomText(
                  text:
                      "Your Order will be delivered soon.\nThank you for choosing our app!",
                  fontSize: 4.5,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomButton(
                    text: "Continue Shopping",
                    onPressed: () {
                      Get.to(() => const DashboardScreen(
                            selectedIndex: 0,
                          ));
                    }),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

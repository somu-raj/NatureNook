// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Custom Widgets/fonts.dart';
import 'package:nature_nook_app/Screens/auth/Forget Password/forget_password_screen.dart';
import 'package:nature_nook_app/Screens/auth/Registration/verify_mobile_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  final bool canPop;

  const LoginScreen({super.key, this.canPop = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.canPop,
      onPopInvokedWithResult: (val, _) async {
        bool shouldExit =
            await Utils.showConfirmDialog("Exit", 'Do you want to exit?');
        if (shouldExit) {
          exit(0); // Exit the app
        }
      },
      child: Scaffold(
        body: Container(
          height: h,
          padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 30),
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
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: large * 0.01,
                  ),
                  const CustomText(
                      text: "Login to your \nAccount.",
                      fontSize: 10,
                      color: NatureColor.allApp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: large * 0.01,
                  ),
                  const CustomText(
                      text: "Please sign in to your account",
                      fontSize: 4.5,
                      color: NatureColor.colorOutlineBorder,
                      fontWeight: FontWeight.normal),
                  SizedBox(
                    height: large * 0.05,
                  ),
                  const CustomText(
                    text: "Mobile Number",
                    fontSize: 4,
                    color: NatureColor.allApp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: large * 0.01,
                  ),
                  CustomTextFormField(
                    isDense: false,
                    filled: true,
                    fillColor: NatureColor.whiteTemp,
                    hintText: "Enter mobile number",
                    controller: loginController.mobileController,
                    textInputType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  SizedBox(
                    height: large * 0.02,
                  ),
                  const CustomText(
                      text: "Password",
                      fontSize: 4,
                      color: NatureColor.allApp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: large * 0.01,
                  ),
                  Obx(() {
                    return CustomTextFormField(
                      isDense: false,
                      filled: true,
                      fillColor: NatureColor.whiteTemp,
                      hintText: "Enter password",
                      controller: loginController.passwordController,
                      obscureText: !loginController.passwordVisible.value,
                      suffixIcon: loginController.passwordVisible.value
                          ? InkWell(
                              onTap: () {
                                loginController.togglePasswordVisibility();
                              },
                              child: const Icon(Icons.visibility))
                          : InkWell(
                              onTap: () {
                                loginController.togglePasswordVisibility();
                              },
                              child: const Icon(Icons.visibility_off)),
                      onChanged: (value) {},
                    );
                  }),
                  SizedBox(
                    height: large * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => ForgetPasswordScreen(
                                loginController: loginController,
                              ));
                        },
                        child: const CustomText(
                            text: "Forgot Password?",
                            fontSize: 3.5,
                            color: NatureColor.primary2,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: large * 0.02,
                  ),
                  Center(
                    child: Obx(() {
                      return !loginController.isLoading.value
                          ? CustomButton(
                              text: 'Login',
                              onPressed: () {
                                // Get.to(() =>  const VerifyOtpScreen(otp: "1234", contactDetail: "1234567890", sendVia: "mobile"));

                                loginController.login();
                              },
                            )
                          : const CircularProgressIndicator();
                    }),
                  ),
                  SizedBox(
                    height: large * 0.04,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                          fontFamily: Fonts.montserrat,
                          color: NatureColor.colorFillText,
                          fontSize: Constants.getResponsiveFontSize(4.5),
                          fontWeight: FontWeight.normal,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: " Register",
                            style: TextStyle(
                              fontFamily: Fonts.roboto, //Fonts.roboto,
                              color: NatureColor.primary2,
                              fontSize: Constants.getResponsiveFontSize(4.5),
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => VerifyMobileScreen(
                                      loginController: loginController,
                                    ));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

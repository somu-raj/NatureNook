// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Auth%20Controllers/reset_password_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, this.changePassword = false, this.mobile});

  final bool changePassword;
  final String? mobile;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPasswordController resetPasswordController =
      Get.put(ResetPasswordController());

  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: h,
        padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: 5),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: widget.changePassword
                                ? "Change Password"
                                : "Reset Password",
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: large * 0.02,
                ),
                const CustomText(
                    text:
                        "Your new password must be different from your\npreviously used password",
                    fontSize: 4,
                    color: NatureColor.colorOutlineBorder,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: large * 0.03,
                ),
                widget.changePassword
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Old Password",
                            fontSize: 4,
                            color: NatureColor.allApp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: large * 0.01,
                          ),
                          Obx(() {
                            return CustomTextFormField(
                                isDense: false,
                                filled: true,
                                fillColor: NatureColor.whiteTemp,
                                hintText: "Enter old password",
                                obscureText: !resetPasswordController
                                    .oldPasswordVisible.value,
                                controller: resetPasswordController
                                    .oldPasswordController,
                                suffixIcon: InkWell(
                                    onTap: () {
                                      resetPasswordController
                                          .toggleOldPasswordVisibility();
                                    },
                                    child: resetPasswordController
                                            .oldPasswordVisible.value
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)));
                          }),
                          SizedBox(
                            height: large * 0.02,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const CustomText(
                  text: "New Password",
                  fontSize: 4,
                  color: NatureColor.allApp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: large * 0.01,
                ),
                Form(
                  key: resetPasswordController.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return CustomTextFormField(
                          isDense: false,
                          filled: true,
                          fillColor: NatureColor.whiteTemp,
                          hintText: "Enter new password",
                          controller:
                              resetPasswordController.newPasswordController,
                          obscureText:
                              !resetPasswordController.newPasswordVisible.value,
                          suffixIcon: InkWell(
                              onTap: () {
                                resetPasswordController
                                    .togglePasswordVisibility();
                              },
                              child: resetPasswordController
                                      .newPasswordVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else if (val.contains(' ')) {
                              return 'invalid';
                            } else if (val.length < 8) {
                              return 'Must be at lease 8 characters';
                            }
                            return null;
                          },
                        );
                      }),
                      SizedBox(
                        height: large * 0.02,
                      ),
                      const CustomText(
                          text: "Confirm Password",
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
                          hintText: "Enter confirm password",
                          controller:
                              resetPasswordController.confirmPasswordController,
                          obscureText: !resetPasswordController
                              .confirmPasswordVisible.value,
                          suffixIcon: InkWell(
                              onTap: () {
                                resetPasswordController
                                    .toggleConfirmPasswordVisibility();
                              },
                              child: resetPasswordController
                                      .confirmPasswordVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else if (val !=
                                resetPasswordController
                                    .newPasswordController.text) {
                              return 'Not Matched';
                            }
                            return null;
                          },
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: large * 0.03,
                ),
                CustomButton(
                  text: widget.changePassword
                      ? 'Change Password'
                      : 'Reset Password',
                  onPressed: () {
                    if (widget.changePassword &&
                        resetPasswordController
                            .oldPasswordController.text.isEmpty) {
                      Utils.mySnackBar(title: "Old password is required");
                      return;
                    } else if (resetPasswordController.formKey.currentState!
                        .validate()) {
                      if (widget.changePassword) {
                        resetPasswordController.updatePassword().then((value) {
                          if (value) {
                            showChangePasswordSuccessBottomSheet();
                          }
                        });
                      } else {
                        resetPasswordController
                            .resetPassword(widget.mobile.toString())
                            .then((value) {
                          if (value) {
                            showChangePasswordSuccessBottomSheet();
                          }
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///show on password change successfully
  void showChangePasswordSuccessBottomSheet() {
    Get.bottomSheet(Responsive(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 12, bottom: 20),
        decoration: const BoxDecoration(
            color: NatureColor.whiteTemp,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                  color: NatureColor.textFormBackColors,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/successImage.png",
                  height: large * 0.25,
                ),
                SizedBox(
                  height: large * 0.03,
                ),
                const CustomText(
                    text: "Password Changed",
                    fontSize: 7,
                    color: NatureColor.allApp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: large * 0.01,
                ),
                const CustomText(
                  text:
                      "Password change successfully, you can login again with new password",
                  fontSize: 4.1,
                  color: NatureColor.colorOutlineBorder,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: large * 0.03,
                ),
                CustomButton(
                  text: 'Go to Login',
                  onPressed: () {
                    Get.to(() => const LoginScreen());
                    Get.delete<ResetPasswordController>();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    resetPasswordController.newPasswordController.clear();
    resetPasswordController.confirmPasswordController.clear();
    resetPasswordController.oldPasswordController.clear();
  }
}

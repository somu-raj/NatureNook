// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Auth%20Controllers/registration_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Custom Widgets/fonts.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobileNumber;

  const RegistrationScreen({super.key, required this.mobileNumber});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                    text: "Create Your new\nAccount.",
                    fontSize: 10,
                    color: NatureColor.allApp,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: large * 0.01,
                ),
                const CustomText(
                    text:
                        "Create an account for start looking for the food you like ",
                    fontSize: 4.5,
                    color: NatureColor.colorOutlineBorder,
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: large * 0.02,
                ),
                Form(
                  key: registrationController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Full Name",
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
                        hintText: "Enter your full name",
                        controller: registrationController.nameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: large * 0.02,
                      ),
                      const CustomText(
                        text: "Email Address",
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
                        textInputType: TextInputType.emailAddress,
                        hintText: "Enter your email",
                        controller: registrationController.emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: large * 0.02,
                      ),
                      /* const CustomText(
                        text: "Phone Number",
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
                        hintText: "Enter your phone number",
                        controller: registrationController.phoneController,
                        textInputType: TextInputType.phone,
                        maxLength: 10,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'required';
                          }else if(val.length < 10){
                            return 'invalid mobile';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: large * 0.02,
                      ),*/
                      const CustomText(
                        text: "Referral Code",
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
                        hintText: "Enter your referral code",
                        controller: registrationController.referralController,
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
                          hintText: "Enter your password",
                          controller: registrationController.passwordController,
                          obscureText:
                              !registrationController.passwordVisible.value,
                          suffixIcon: InkWell(
                              onTap: () {
                                registrationController
                                    .togglePasswordVisibility();
                              },
                              child:
                                  registrationController.passwordVisible.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'required';
                            } else if (val.length < 8) {
                              return 'must have at least 8 character';
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
                Obx(() {
                  return Center(
                    child: !registrationController.isLoading.value
                        ? CustomButton(
                            text: 'Sign Up',
                            onPressed: () {
                              registrationController
                                  .register(widget.mobileNumber);
                            },
                          )
                        : const CircularProgressIndicator(),
                  );
                }),
                SizedBox(
                  height: large * 0.04,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(
                        fontFamily: Fonts.montserrat,
                        color: NatureColor.colorFillText,
                        fontSize: Constants.getResponsiveFontSize(4.5),
                        fontWeight: FontWeight.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " Sign In",
                          style: TextStyle(
                            fontFamily: Fonts.roboto, //Fonts.roboto,
                            color: NatureColor.primary2,
                            fontSize: Constants.getResponsiveFontSize(4.5),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate back to login screen
                              Get.back();
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
    );
  }
}

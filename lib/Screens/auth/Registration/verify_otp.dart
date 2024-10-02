// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Auth Controllers/login_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/fonts.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String mobileNumber;

  const VerifyOtpScreen({super.key, required this.mobileNumber});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;
  LoginController loginController = Get.put(LoginController());

  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  /// get next or previous field
  void nextField(String value, int index) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  ///get otp from all controllers
  String getOtp() {
    String otp =
        '${_controllers[0].text}${_controllers[1].text}${_controllers[2].text}${_controllers[3].text}';
    return otp;
  }

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
        child: SafeArea(
          child: Responsive(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios, size: 30)),
                        const CustomText(
                            text: "OTP Verification",
                            fontSize: 9,
                            color: NatureColor.allApp,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                    SizedBox(
                      height: large * 0.01,
                    ),
                    CustomText(
                        text:
                            "Enter the verification code we send you on ${widget.mobileNumber}",
                        fontSize: 5,
                        color: NatureColor.colorOutlineBorder,
                        fontWeight: FontWeight.normal),
                    SizedBox(
                      height: large * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: large * 0.08,
                          height: large * 0.08,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24),
                            decoration: InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) => nextField(value, index),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: large * 0.03,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive code?",
                          style: TextStyle(
                            fontFamily: Fonts.montserrat,
                            color: NatureColor.colorFillText,
                            fontSize: Constants.getResponsiveFontSize(4.5),
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " Resend",
                              style: TextStyle(
                                fontFamily: Fonts.roboto, //Fonts.roboto,
                                color: NatureColor.primary2,
                                fontSize: Constants.getResponsiveFontSize(4.5),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  loginController.verifyRegisterMobile();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: CustomButton(
                    text: 'Verify',
                    onPressed: () {
                      String otp = getOtp();
                      loginController.verifyOtp(otp);
                      // Get.back();
                      // Get.to(() =>  RegistrationScreen(mobileNumber: widget.contactDetail,));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

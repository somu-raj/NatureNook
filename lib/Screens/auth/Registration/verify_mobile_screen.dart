// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Auth%20Controllers/login_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Screens/auth/Forget%20Password/confirm_otp_screen.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class VerifyMobileScreen extends StatefulWidget {
  final LoginController loginController;

  const VerifyMobileScreen({super.key, required this.loginController});

  @override
  State<VerifyMobileScreen> createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                      text: "Please enter\nyour mobile no.",
                      fontSize: 10,
                      color: NatureColor.allApp,
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    height: large * 0.01,
                  ),
                  const CustomText(
                      text:
                          "Look for a field where you need to enter\nyour mobile number. Enter your number carefully,",
                      fontSize: 4.5,
                      color: NatureColor.colorOutlineBorder,
                      fontWeight: FontWeight.normal),
                  SizedBox(
                    height: large * 0.04,
                  ),
                  /*const CustomText(
                    text: "Enter Mobile Number",
                    fontSize: 4,
                    color: NatureColor.allApp,

                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: large * 0.01,
                  ),*/
                  CustomTextFormField(
                    maxLength: 10,
                    isDense: false,
                    filled: true,
                    fillColor: NatureColor.whiteTemp,
                    hintText: "Enter mobile",
                    textInputType: TextInputType.number,
                    controller: widget.loginController.verifyMobileController,
                  ),
                ],
              ),
              Center(
                child: CustomButton(
                  text: 'Send OTP',
                  onPressed: () {
                    widget.loginController.verifyRegisterMobile();
                  },
                ),
              ),
              /*Center(
                child: CustomButton(
                  text: 'Send OTP',
                  onPressed: () {

                    widget.loginController.verifyMobileAndSendCode().then((val) {
                      if (val) {
                        Get.to((){
                          return VerifyOtpScreen(otp: "5360",  contactDetail: widget.loginController.mobileController.text);
                        });
                       // showBottomSheet();
                      }
                    });
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  ///show bottom sheet for sending the code
  /* void showBottomSheet() {
    Get.bottomSheet(Responsive(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .copyWith(top: 12, bottom: 20),
        decoration: const BoxDecoration(
            color: NatureColor.whiteTemp,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                    color: NatureColor.textFormBackColors,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: large * 0.01,
            ),
            const CustomText(
                text: "Forgot Password?",
                fontSize: 8,
                color: NatureColor.allApp,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: large * 0.01,
            ),
            const CustomText(
                text:
                    "Select which contact detail should we use to reset your password",
                fontSize: 3.5,
                color: NatureColor.colorOutlineBorder,
                fontWeight: FontWeight.normal),
            SizedBox(
              height: large * 0.02,
            ),
            Obx(() {
              return InkWell(
                onTap: () {
                  widget.loginController.selectedIndex.value = 0;
                },
                child: ContactDetailBox(
                  isSelected: widget.loginController.selectedIndex.value == 0,
                  textSendVia: 'Whatsapp',
                  contactDetail: '+91 7977 797 755',
                  contactIconImage: 'assets/icons/whatsapp_box.png',
                ),
              );
            }),
            SizedBox(
              height: large * 0.02,
            ),
            Obx(() {
              return InkWell(
                onTap: () {
                  widget.loginController.selectedIndex.value = 1;
                },
                child: ContactDetailBox(
                  isSelected: widget.loginController.selectedIndex.value == 1,
                  textSendVia: 'Email',
                  contactDetail: 'hariom@naturenookmart.com',
                  contactIconImage: 'assets/icons/email_box.png',
                ),
              );
            }),
            SizedBox(
              height: large * 0.04,
            ),
            CustomButton(
                text: "Continue",
                onPressed: () {
                  Get.back();
                  Get.to(() => const ConfirmOtpScreen(
                      otp: "1234",
                      contactDetail: "hariom@naturenookmart.com",
                      sendVia: "Email"));
                })
          ],
        ),
      ),
    ));
  }*/

  ///dispose method when screen is disposed
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.loginController.forgetPassMobileController.clear();
  }
}

///custom box for contact details
class ContactDetailBox extends StatelessWidget {
  final String textSendVia;
  final String contactDetail;
  final String contactIconImage;
  final bool isSelected;

  const ContactDetailBox(
      {super.key,
      required this.textSendVia,
      required this.contactDetail,
      required this.contactIconImage,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              width: 2,
              color: isSelected
                  ? NatureColor.primary1
                  : NatureColor.textFormBackColors)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            contactIconImage,
            height: Constants.largeSize * 0.05,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Send via $textSendVia",
                fontSize: 4,
                color: NatureColor.textFormBackColors,
              ),
              SizedBox(
                height: Constants.largeSize * 0.01,
              ),
              SizedBox(
                width: Constants.screen.width * 0.52,
                child: Flexible(
                  child: CustomText(
                    text: contactDetail,
                    fontSize: 4,
                    color: NatureColor.blackColor,
                    overFlow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          ),
          isSelected
              ? Image.asset(
                  "assets/icons/right_icon.png",
                  height: Constants.largeSize * 0.05,
                )
              : SizedBox(
                  width: Constants.largeSize * 0.05,
                ),
        ],
      ),
    );
  }
}

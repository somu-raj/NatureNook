// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:share/share.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({super.key, required this.referAndEarn});
  final String referAndEarn;

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {

  double h = Constants.screen.height;
  double w = Constants.screen.width;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: h,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              NatureColor.scaffoldBackGround,
              NatureColor.scaffoldBackGround1,
              NatureColor.scaffoldBackGround1,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "Refer and Earn",
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset("assets/images/refer.png"),
                    const CustomText(
                      text: "Refer and Earn",
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      color: NatureColor.secondary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      child: CustomText(
                        text:
                            "Invite your friends to join and get the reward\n    soon as your friend first order placed. ",
                        fontSize: 4.0,
                        fontWeight: FontWeight.normal,
                        color: NatureColor.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: "Your Referral Code",
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                      color: NatureColor.secondary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.referAndEarn.isEmpty ? const SizedBox.shrink():  GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text:widget.referAndEarn));
                        Utils.mySnackBar(title: "Code copied to clipboard");
                      },
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                          color: NatureColor.whiteTemp,
                          borderRadius: BorderRadius.circular(7),
                          border:
                              Border.all(color: NatureColor.textFormBackColors),
                        ),
                        child: Center(
                          child: widget.referAndEarn.isEmpty
                              ? const Text(
                                  "No referral code",
                                  style: TextStyle(
                                      fontSize: 16), // Customize as needed
                                )
                              : Text(
                                  widget.referAndEarn,
                                  style: const TextStyle(
                                      fontSize: 16), // Customize as needed
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    widget.referAndEarn.isEmpty ? const SizedBox():  Column(
                      children: [
                        InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.referAndEarn));
                              Utils.mySnackBar(msg: "Text copied to clipboard");
                            },
                            child: const CustomText(
                              text: "Tap to Copy",
                              fontSize: 4,
                              fontWeight: FontWeight.bold,
                              color: NatureColor.secondary,
                            )),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton(
                              height: 55,
                              text: "Share Referral Code",
                              onPressed: () {
                                Share.share(widget.referAndEarn,
                                    subject: 'Look what I made!');
                              }),
                        )
                      ],
                    )

                  ],
                ),
              )),
        ),
      ),
    );
  }
}

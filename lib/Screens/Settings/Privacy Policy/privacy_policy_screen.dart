// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/color/colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key, required this.privacyPolicy});
  final String privacyPolicy;

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                                text: "Privacy Policy",
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: widget.privacyPolicy.isEmpty
                            ? const CustomText(
                                text: "No Content....",
                                fontSize: 5,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.justify,
                              )
                            : Html(
                                data: widget.privacyPolicy,
                                style: {
                                  "body": Style(
                                    fontWeight:
                                        FontWeight.normal, // Make text bold
                                    fontSize:
                                        FontSize(16.0), // Increase font size
                                    textAlign: TextAlign
                                        .justify, // Justify text alignment
                                  ),
                                },
                              )

                        //child: CustomText(text: "Fine Organics Industries Limited is committed to meet the applicable requirements of European data protection Fine Organics Industries Limited is committed to meet the applicable requirements of European data protection Fine Organics Industries Limited is committed to meet the applicable requirements of European data protection laws and will responsibly protect the information you provide to us and the information we collect in the course of operating our practices",
                        //  fontSize: 4,),
                        )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

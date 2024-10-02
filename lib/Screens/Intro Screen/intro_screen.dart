// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/custom_painters.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/scale_size.dart';
import 'package:nature_nook_app/notification_services.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    LocalNotificationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          IntroPage(
            image: "assets/intro_images/intro_1.jpg",
            title: "Welcome to\n Nature Nook",
            description:
                "All the best organic products with there top manu waiting for you, they can't wait for your order!!",
            pageController: pageController,
          ),
          IntroPage(
            image: "assets/intro_images/intro_2.jpg",
            title: "We serve incomparable Organic Products",
            description:
                "All the best organic products with there top manu waiting for you, they can't wait for your order!!",
            pageController: pageController,
          ),
          IntroPage(
            image: "assets/intro_images/intro_3.jpg",
            title: "We serve incomparable Organic Products",
            description:
                "All the best organic products with there top manu waiting for you, they can't wait for your order!!",
            isLastPage: true,
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isLastPage;
  final PageController pageController;

  const IntroPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.isLastPage = false,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Constants.screen.height,
        width: Constants.screen.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Constants.screen.height * 0.51,
            width: Constants.screen.width * 0.84,
            margin: EdgeInsets.only(
                bottom: Constants.screen.height *
                    0.03) /*.copyWith(bottom: Constants.screen.height*0.03)*/,
            padding: const EdgeInsets.symmetric(horizontal: 24)
                .copyWith(top: 32, bottom: 16),
            decoration: BoxDecoration(
                color: NatureColor.primary1.withOpacity(0.7),
                gradient: const LinearGradient(
                  colors: [NatureColor.primary1, NatureColor.primary2],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(48)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactor(maxTextScaleFactor: 3.5)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      textScaler: TextScaler.linear(
                          ScaleSize.textScaleFactor(maxTextScaleFactor: 1.5)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                // SizedBox(height:Constants.screen.height*0.1,),
                Column(
                  children: [
                    isLastPage
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomPaint(
                                // size: Size(Constants.screen.width*0.3,Constants.screen.width*0.3),
                                painter: CirclePainter(),
                                child: InkWell(
                                  onTap: () {
                                    SharedPref.setFirstAsFalse();
                                    Get.to(() => const DashboardScreen(
                                          selectedIndex: 0,
                                        ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    height: Constants.screen.width * 0.2,
                                    width: Constants.screen.width * 0.2,
                                    decoration: const BoxDecoration(
                                        color: NatureColor.whiteTemp,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      "assets/images/arrow_forward.png",
                                      color: NatureColor.primary,
                                      height: Constants.screen.height * 0.02,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeInOut);
                                },
                                child: Text(
                                  "Skip",
                                  textScaler: TextScaler.linear(
                                      ScaleSize.textScaleFactor(
                                          maxTextScaleFactor: 2)),
                                  style: const TextStyle(
                                      color: NatureColor.whiteTemp),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Next ",
                                      textScaler: TextScaler.linear(
                                          ScaleSize.textScaleFactor(
                                              maxTextScaleFactor: 2)),
                                      style: const TextStyle(
                                          color: NatureColor.whiteTemp),
                                    ),
                                    Image.asset(
                                      "assets/images/arrow_forward.png",
                                      color: NatureColor.whiteTemp,
                                      height: Constants.screen.height * 0.02,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

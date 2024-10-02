// Flutter imports:
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:share/share.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Profile Controller/Update Controller/profile_update_controller.dart';
import 'package:nature_nook_app/Controllers/Setting%20Controller/setting_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/custom_profile_container.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Screens/Order/order_list.dart';
import 'package:nature_nook_app/Screens/Settings/About Us/about_us_screen.dart';
import 'package:nature_nook_app/Screens/Settings/Contact Us/contact_us_screen.dart';
import 'package:nature_nook_app/Screens/Settings/Faq/faq_screen.dart';
import 'package:nature_nook_app/Screens/Settings/Privacy Policy/privacy_policy_screen.dart';
import 'package:nature_nook_app/Screens/Settings/ReferEran/refer_and_earn.dart';
import 'package:nature_nook_app/Screens/Settings/Terms and Condition/terms_and_condition_screen.dart';
import 'package:nature_nook_app/Screens/User Profile/Manage Address/manage_address.dart';
import 'package:nature_nook_app/Screens/User Profile/Transaction/my_transaction_screen.dart';
import 'package:nature_nook_app/Screens/User Profile/Update Profile/update_profile_screen.dart';
import 'package:nature_nook_app/Screens/User Profile/Wallet/wallet_screen.dart';
import 'package:nature_nook_app/Screens/User%20Profile/profile_not_found_screen.dart';
import 'package:nature_nook_app/Screens/auth/Forget%20Password/reset_password_screen.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;

  ProfileController profileController = Get.put(ProfileController());
  SettingController settingController = Get.put(SettingController());

  @override
  void initState() {
    if (profileController.userId.isEmpty) return;
    profileController.refresh().then((val) {
      setState(() {});
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error!', msg: e.toString());
    });
    settingController.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await profileController.getUserProfile();
      },
      child: Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              child: SafeArea(
                child: profileController.userId.isEmpty
                    ? const ProfileNotFound()
                    : Obx(() {
                        return Column(
                          children: [
                            const SizedBox(
                              // height: h * 0.15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(),
                                  CustomText(
                                    text: "Profile",
                                    fontSize: 7,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            profileController.profileData.value == null
                                ? const Center(
                                    child: CupertinoActivityIndicator())
                                : Column(
                                    children: [
                                      Stack(
                                        children: [
                                          /*  profileController.profileImage.isEmpty
                                              ?*/
                                          Container(
                                            decoration: BoxDecoration(
                                                color: NatureColor.whiteTemp,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  profileController.profileData
                                                          .value?.image ??
                                                      '',
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          /*  : Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          NatureColor.whiteTemp,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: Image.asset(
                                                    'assets/images/nature_logo.png',
                                                    height: 120,
                                                    width: 120,
                                                  ),
                                                ),*/
                                          Positioned(
                                            top: 90,
                                            bottom: 0,
                                            left: 70,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () async {
                                                bool? shouldUpdate =
                                                    await Get.to(() =>
                                                        const UpdateProfileScreen());
                                                if (shouldUpdate ?? false) {
                                                  await profileController
                                                      .refresh();
                                                  setState(() {});
                                                }
                                              },
                                              child: Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                    color: NatureColor.primary
                                                        .withOpacity(0.5),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color:
                                                          NatureColor.whiteTemp,
                                                    )),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: NatureColor.whiteTemp,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text:
                                            "${profileController.profileData.value?.username}",
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      profileController
                                                  .profileData.value?.email ==
                                              null
                                          ? const CustomText(
                                              text: "No email",
                                              fontSize: 5,
                                              fontWeight: FontWeight.normal,
                                              color: NatureColor
                                                  .colorOutlineBorder,
                                            )
                                          : CustomText(
                                              text:
                                                  "${profileController.profileData.value?.email}",
                                              fontSize: 6,
                                              fontWeight: FontWeight.normal,
                                              color: NatureColor
                                                  .colorOutlineBorder,
                                            ),
                                    ],
                                  ),
                            const SizedBox(height: 20),
                            profileController.profileData.value == null
                                ? myShimmer(height: 50)
                                : listMenuView(),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  listMenuView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CustomListContainer(
              iconPath: "assets/icons/Profile/My Orders.png",
              text: "My Orders",
              onTap: () {
                Get.to(() => const OrderListScreen());
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Manage Address.png",
              text: "Manage Address",
              onTap: () {
                Get.to(() => const ManageAddressScreen());
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/My Wallet.png",
              text: "My Wallet",
              onTap: () {
                Get.to(() => const WalletScreen());
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/My Transactions.png",
              text: "My Transactions",
              onTap: () {
                Get.to(() => const MyTransactionScreen());
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Change Password.png",
              text: "Change Password",
              onTap: () {
                Get.to(() => const ResetPasswordScreen(
                      changePassword: true,
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Refer and Earn.png",
              text: "Refer & Earn",
              onTap: () {
                Get.to(() => ReferAndEarn(
                    referAndEarn: profileController
                            .profileData.value?.referralCode
                            .toString() ??
                        ""));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/About Us.png",
              text: "About Us",
              onTap: () {
                Get.to(() => AboutUsScreen(
                      aboutUsContent: settingController
                              .getSettingModel?.data?.aboutUs.first ??
                          '',
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Contact Us.png",
              text: "Contact Us",
              onTap: () {
                Get.to(() => ContactUsScreen(
                      contactUs: settingController
                              .getSettingModel?.data?.contactUs.first ??
                          "",
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Faqs.png",
              text: "Faqs",
              onTap: () {
                Get.to(() => const FaqsScreen());
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Privacy Policy.png",
              text: "Privacy Policy",
              onTap: () {
                Get.to(() => PrivacyPolicyScreen(
                      privacyPolicy: settingController
                              .getSettingModel?.data?.privacyPolicy.first ??
                          "",
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Term & Conditions.png",
              text: "Term and Conditions",
              onTap: () {
                Get.to(() => TermsAndCondition(
                      termsAndCondition: settingController
                              .getSettingModel?.data?.termsConditions.first ??
                          "",
                    ));
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Rate Us.png",
              text: "Rate Us",
              onTap: () {
                _launchUrl();
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Share.png",
              text: "Share",
              onTap: () {
                Share.share(
                    'Hello I,m Nature Nook Application https://naturenookmart.com/',
                    subject: 'Look what I made!');
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/user.png",
              text: "User Delete",
              onTap: () async {
                bool confirmDelete = await Utils.showConfirmDialog(
                    "Delete Account", 'Do you want to delete user?');
                if (confirmDelete) {
                  profileController
                      .showConfirmDialogDeletePopup('Delete Account');
                }
              }),
          const SizedBox(
            height: 10,
          ),
          CustomListContainer(
              iconPath: "assets/icons/Profile/Logout.png",
              text: "Logout",
              onTap: () async {
                bool confirmLogOut = await Utils.showConfirmDialog(
                    "Log Out", 'Do you want to Log out?');
                if (confirmLogOut) {
                  SharedPref.setLogOut();
                  Get.to(() => const LoginScreen());
                }
              })
        ],
      ),
    );
  }

  final Uri _url = Uri.parse('https://play.google.com/store/apps?hl=en');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

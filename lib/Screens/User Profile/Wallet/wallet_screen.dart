// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api%20Services/api_services.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customAppBar.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;

  @override
  void initState() {
    getWalletApi();
    super.initState();
  }

  ///api helper instances
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get _userId => SharedPref.getUserId();

  ///api urls
  String get wallet => apiServices.getWallet;

  String? amount;
  getWalletApi() async {
    final dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(wallet), {'user_id': _userId});
    if (response['error'] ?? true) {
      Utils.mySnackBar(
          title: 'Error Found',
          msg: response['message'] ?? 'something went wrong, please try again');
      amount = '0';
    } else {
      amount = response['data'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomSimpleAppBar(title: 'Wallet'),
      extendBodyBehindAppBar: true,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              children: [
                Responsive(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: NatureColor.whiteTemp,
                        border: Border.all(
                            color: NatureColor.textFormBackColors
                                .withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet),
                            SizedBox(
                              width: 6,
                            ),
                            CustomText(
                              text: "Current Balance",
                              fontSize: 6.0,
                              color: NatureColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        amount == null
                            ? Transform.scale(
                                scale: 0.6,
                                child: const CircularProgressIndicator(),
                              )
                            : CustomText(
                                text: "₹ ${amount == "0" ? '0.00' : amount}",
                                fontSize: 7.0,
                                color: NatureColor.blackColor,
                                fontWeight: FontWeight.bold,
                              )
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

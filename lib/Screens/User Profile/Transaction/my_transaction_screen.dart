// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Transcation Controller/transaction_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class MyTransactionScreen extends StatefulWidget {
  const MyTransactionScreen({super.key});

  @override
  State<MyTransactionScreen> createState() => _MyTransactionScreenState();
}

class _MyTransactionScreenState extends State<MyTransactionScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;

  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  void initState() {
    transactionController.pageLoading.value = true;
    transactionController.refresh().then((val) {
      transactionController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await transactionController.refresh();
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
                                  text: "My Transactions",
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      buildListView(), // Call your ListView builder here
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Obx(() {
      return transactionController.pageLoading.value
          ? Center(child: myShimmer(height: 100))
          : transactionController.transactionListData.isEmpty
              ? const Center(child: Text("No Transactions History..."))
              : ListView.builder(
                  itemCount: transactionController.transactionListData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    var transactionList =
                        transactionController.transactionListData[i];
                    DateTime transactionDateTime = DateTime.parse(
                        "${transactionController.transactionListData[i].transactionDate}");
                    String date =
                        "${transactionDateTime.year}-${transactionDateTime.month}-${transactionDateTime.day}";
                    String time =
                        "${transactionDateTime.hour}:${transactionDateTime.minute}";

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: NatureColor.whiteTemp,
                              border: Border.all(
                                  color: NatureColor.textFormBackColors
                                      .withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  CustomText(
                                    text: "Date: $date Time: $time",
                                    fontSize: 4.0,
                                    color: NatureColor.textFormBackColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  //CustomText(text: "Date:22/08/2024 Time:11:00 AM", fontSize: 4.0,color: NatureColor.textFormBackColors,fontWeight: FontWeight.normal,),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "₹ ${transactionList.amount}",
                                        fontSize: 5.0,
                                        color: NatureColor.allApp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text: "${transactionList.status}",
                                        fontSize: 4.0,
                                        color: NatureColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
    });
  }
}

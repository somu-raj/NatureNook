// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Seller%20Controller/seller_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customAppBar.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Home/brand_model.dart';
import 'package:nature_nook_app/Screens/Product/products_list_screen.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class SellerDetails extends StatefulWidget {
  final BrandData seller;
  const SellerDetails({super.key, required this.seller});

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  double large = Constants.largeSize;
  double w = Constants.screen.width;

  SellerController sellerController = Get.put(SellerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSimpleAppBar(title: widget.seller.storeName ?? ''),
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
          child: Obx(() => ListView(
                children: [
                  Container(
                    height: 55,
                    color: NatureColor.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            sellerController.updateCurrentIndex(0);
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: sellerController.currentIndex.value == 0
                                  ? NatureColor.whiteTemp
                                  : NatureColor.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Details",
                                style: TextStyle(
                                  color:
                                      sellerController.currentIndex.value == 0
                                          ? NatureColor.primary
                                          : NatureColor.whiteTemp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            sellerController.updateCurrentIndex(1);
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: sellerController.currentIndex.value == 1
                                  ? NatureColor.whiteTemp
                                  : NatureColor.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Products",
                                style: TextStyle(
                                  color:
                                      sellerController.currentIndex.value == 1
                                          ? NatureColor.primary
                                          : NatureColor.whiteTemp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  sellerController.currentIndex.value == 0
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              height: large * 0.32,
                              width: large * 0.37,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: NatureColor.whiteTemp,
                                borderRadius: BorderRadius.circular(15),
                                border: const Border(
                                  bottom: BorderSide(
                                      color: NatureColor.primary1, width: 3),
                                  top: BorderSide(
                                      color: NatureColor.primary1, width: 1),
                                  left: BorderSide(
                                      color: NatureColor.primary1, width: 1),
                                  right: BorderSide(
                                      color: NatureColor.primary1, width: 1),
                                ),
                              ),
                              child: Image.network(
                                  widget.seller.sellerProfile ?? ''),
                            ),
                            const SizedBox(height: 15),
                            CustomText(
                              text:
                                  "Brand Name: ${widget.seller.sellerName ?? ''}",
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: NatureColor.primary,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.star,
                                        color: NatureColor.whiteTemp,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    CustomText(
                                      text: double.parse(
                                              widget.seller.sellerRating ?? "")
                                          .toStringAsFixed(1),
                                      fontSize: 4.6,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    showSellerDescription();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: NatureColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.note_alt_rounded,
                                          color: NatureColor.whiteTemp,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const CustomText(
                                        text: 'Description',
                                        fontSize: 4.6,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        sellerController.updateCurrentIndex(1);
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: NatureColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Icon(
                                          Icons.list_alt_outlined,
                                          color: NatureColor.whiteTemp,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "Products",
                                      style: TextStyle(
                                        color: NatureColor.blackColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      : ProductListScreen(
                          kKey: 'seller_id',
                          id: widget.seller.sellerId ?? '',
                          onlyProducts: true,
                        ),
                ],
              )),
        ),
      ),
    );
  }

  showSellerDescription() {
    Get.bottomSheet(
        isScrollControlled: true,
        Padding(
          padding: const EdgeInsets.all(12.0).copyWith(bottom: 0),
          child: (widget.seller.storeDescription ?? '').isEmpty
              ? Container(
                  height: Constants.largeSize * 0.4,
                  decoration: const BoxDecoration(
                      color: NatureColor.whiteTemp,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: const Center(
                      child: CustomText(
                          text: 'No Description Available', fontSize: 5.2)))
              : Container(
                  // height: Constants.largeSize * 0.7,
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 12, bottom: 20),
                  decoration: const BoxDecoration(
                      color: NatureColor.whiteTemp,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                        if ((widget.seller.storeDescription ?? '').isNotEmpty)
                          Html(data: widget.seller.storeDescription),
                        const Divider(
                          endIndent: 10,
                          indent: 2,
                          color: NatureColor.blackColor,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}

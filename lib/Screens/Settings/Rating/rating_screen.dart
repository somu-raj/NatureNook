// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Rating Controller/rating_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/myShimmer.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.productId});
  final String productId;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  RatingController ratingController = Get.put(RatingController());

  @override
  void initState() {
    super.initState();
    ratingController.pageLoading.value = true;
    ratingController.getRatingApi(widget.productId).then((val) {
      ratingController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    ratingController.getRatingApi(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await ratingController.getRatingApi(widget.productId);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h*0.06),
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
                            text: "Rating",
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),

                const Padding(
                  padding: EdgeInsets.only(left: 13),
                  child: CustomText(
                    text: "Recent Rating",
                    fontSize: 4.0,
                    color: NatureColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return ratingController.pageLoading.value
                            ? Center(child: myShimmer(height: 90))
                            : ratingController.ratingList.isEmpty
                                ? const Center(
                                    child: CustomText(
                                        text: "No ratings found...",
                                        fontSize: 5))
                                : ListView.builder(
                                  physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        ratingController.ratingList.length,
                                    itemBuilder: (context, index) {
                                      var ratingData =
                                          ratingController.ratingList[index];
                                      return Card(
                                        color: NatureColor.whiteTemp,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    ratingData
                                                            .images.isNotEmpty
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.network(
                                                              ratingData
                                                                  .images[0],
                                                              fit:
                                                                  BoxFit.fill,
                                                              width: 64,
                                                              height: 64,
                                                            ))
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            child:
                                                                Image.asset(
                                                              "assets/images/nature_logo.png",
                                                              fit:
                                                                  BoxFit.fill,
                                                              width: 64,
                                                              height: 64,
                                                            )),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          CustomText(
                                                            text: ratingData
                                                                    .userName ??
                                                                "",
                                                            fontSize: 3.8,
                                                            color: NatureColor
                                                                .primary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          CustomText(
                                                            text: DateFormat(
                                                                    "dd-MMM-yyyy")
                                                                .format(ratingData
                                                                        .dataAdded ??
                                                                    DateTime
                                                                        .now()),
                                                            fontSize: 3.2,
                                                            color: NatureColor
                                                                .blackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          //ratingData.comment ?? ""

                                                           CustomText(
                                                            text: ratingData.comment ?? "" ,
                                                            fontSize: 4.0,
                                                            color: NatureColor.blackColor,
                                                            fontWeight: FontWeight.normal,
                                                            textAlign: TextAlign.start,
                                                            overFlow: TextOverflow.ellipsis,
                                                            maxLines:4,

                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 5,
                                                    vertical: 3),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          ratingData.rating ??
                                                              "",
                                                      fontSize: 3.0,
                                                      color: NatureColor
                                                          .whiteTemp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    const SizedBox(
                                                      width: 2,
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.white,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                      })
                    ],
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

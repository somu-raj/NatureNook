// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Order Controller/order_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Dashboard Models/My Order/get_order_model.dart';
import 'package:nature_nook_app/Screens/Settings/Rating/add_ratting_review.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

import '../Notification/get_notification_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailModel? orderModelList;

  const OrderDetailsScreen({super.key, this.orderModelList});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  int currentIndex = 0;
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    orderController.getOrderModel();

    super.initState();
  }

  String? formattedDate, formattedTime, expectedDate, expectedTime;

  void formatDeliveryDate() {
    String? deliveryDateString = widget.orderModelList?.deliveryDate;
    if (deliveryDateString != null) {
      DateTime expectedDateTime = DateTime.parse(deliveryDateString);
      setState(() {
        expectedDate = DateFormat('dd-MMM-yyyy').format(expectedDateTime);
        expectedTime = DateFormat('hh:mm a').format(expectedDateTime);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find<OrderController>();

    final dateAdded = widget.orderModelList!.orderItems.first.dateAdded;
    formattedDate = DateFormat('dd-MMM-yyyy').format(dateAdded!);
    formattedTime = DateFormat('hh:mm a').format(dateAdded);
    formatDeliveryDate();
    return RefreshIndicator(
      onRefresh: () async {
        await orderController.getOrderModel();
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
                                  text: "Order Details",
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => const NotificationScreen());
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  color: NatureColor.primary,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: buildListView(),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    orderController.downloading.value = true;
    /*log('android version -- $platformVersion');
    orderController.downloading.value = false;
    return;*/
    if(Platform.isIOS ){
      String filePath = await orderController.downloadInvoice(
          widget.orderModelList?.id ?? "",
          widget.orderModelList?.invoiceHtml ?? "");
      orderController.downloading.value = false;
      if(filePath.isNotEmpty){
        Utils.mySnackBar(title: 'Downloaded',msg: 'Invoice downloaded successfully');
      }else{
        Utils.mySnackBar(title: 'Download Error',msg: 'something went wrong, please try again later');
      }
    }
    else {
      int platformVersion = int.parse(Platform.operatingSystemVersion.split(' ').first);
      try {
      if(platformVersion <=11){
        PermissionStatus storagePermissionStatus =
        await Permission.storage.status;
        if(storagePermissionStatus.isDenied || storagePermissionStatus.isPermanentlyDenied){
          storagePermissionStatus =
          await Permission.storage.request();
          if (storagePermissionStatus.isDenied ||
              storagePermissionStatus.isPermanentlyDenied) {
            throw Exception('Permission denied');
          }
        }
        String filePath = await orderController.downloadInvoice(
            widget.orderModelList?.id ?? "",
            widget.orderModelList?.invoiceHtml ?? "");
        if(filePath.isNotEmpty){
          Utils.mySnackBar(title: 'Downloaded',msg: 'Invoice downloaded successfully');
        }else{
          Utils.mySnackBar(title: 'Download Error',msg: 'something went wrong, please try again later');
        }

      }
      else{
          PermissionStatus storagePermissionStatus =
              await Permission.manageExternalStorage.status;
          // await Permission.manageExternalStorage.request();
          if (storagePermissionStatus.isDenied ||
              storagePermissionStatus.isPermanentlyDenied) {
            storagePermissionStatus =
                await Permission.manageExternalStorage.request();
            if (storagePermissionStatus.isDenied ||
                storagePermissionStatus.isPermanentlyDenied) {
              throw Exception('Permission denied');
            }
          }
          else {
            String filePath = await orderController.downloadInvoice(
                widget.orderModelList?.id ?? "",
                widget.orderModelList?.invoiceHtml ?? "");
            if (filePath.isNotEmpty) {
              Utils.mySnackBar(
                  title: 'Downloaded',
                  msg: "Invoice downloaded successfully!",
                  duration: const Duration(seconds: 8),
                  buttonText: 'View',
                  onTap: () {
                    _viewInvoice(filePath);
                  });
              /*ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Invoice downloaded successfully!"),
                duration: const Duration(seconds: 8),
                action: SnackBarAction(
                  label: 'View',
                  onPressed: () {
                    _viewInvoice(filePath);
                  },
                ),
              ),
            );*/
            }
          }
        }
      } catch (e) {
        Utils.mySnackBar(title: "Permission request failed");
      } finally {
        orderController.downloading.value = false;
      }
    }
  }

  void _viewInvoice(String filePath) async {
    try {
      if (await Permission.manageExternalStorage.isGranted) {
        // final url = 'file://$filePath';
        await OpenFile.open(filePath); // Open the file
      } else {
        final manageStoragePermissionStatus =
        await Permission.manageExternalStorage.request();
        if (manageStoragePermissionStatus.isDenied || manageStoragePermissionStatus.isPermanentlyDenied)return;
          // final url = 'file://$filePath';
          await OpenFile.open(filePath); // Open the file
      }
    } catch (e) {
      Utils.mySnackBar(title: "Failed to open file");
    }
  }

  Widget buildListView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: widget.orderModelList!.orderItems.isEmpty
            ? Center(child: myShimmer(height: 100))
            : Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: NatureColor.whiteTemp,
                        border: Border.all(
                            color: NatureColor.textFormBackColors
                                .withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                    "Order ID- ${widget.orderModelList!.orderItems.first.orderId}",
                                fontSize: 3.5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text: "Ordered on: $formattedDate $formattedTime",
                                fontSize: 3.5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text:
                                    "OTP-${widget.orderModelList!.orderItems.first.otp}",
                                fontSize: 3.5,
                                color: NatureColor.textFormBackColors,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: NatureColor.whiteTemp,
                        border: Border.all(
                            color: NatureColor.textFormBackColors
                                .withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text:
                                "Preferred Delivery Date/Time :\n $expectedDate - $expectedTime",
                            fontSize: 3.5,
                            color: NatureColor.textFormBackColors,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.orderModelList!.orderItems.length,
                      itemBuilder: (context, index) {
                        var orderDetails =
                            widget.orderModelList!.orderItems[index];
                        String productId = widget.orderModelList!
                                .orderItems[index].productId ??
                            '';
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: NatureColor.whiteTemp,
                              border: Border.all(
                                  color: NatureColor.textFormBackColors
                                      .withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: h * 0.14,
                                      width: h * 0.16,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.4),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${orderDetails.image}"),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                                "${orderDetails.productName}",
                                            fontSize: 4.5,
                                            color: NatureColor.allApp),
                                        orderDetails.variantName == ""
                                            ? const SizedBox.shrink()
                                            : CustomText(
                                                text:
                                                    "${orderDetails.variantName}",
                                                fontSize: 3.5,
                                                color: NatureColor
                                                    .textFormBackColors,
                                              ),
                                        CustomText(
                                          text:
                                              "Qty: ${orderDetails.quantity}",
                                          fontSize: 3.5,
                                          color:
                                              NatureColor.textFormBackColors,
                                        ),
                                        CustomText(
                                          text:
                                              "₹${orderDetails.specialPrice}",
                                          fontSize: 3.5,
                                          color: NatureColor.allApp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const CustomText(
                                      text: " Order Status :",
                                      fontSize: 4,
                                      color: NatureColor.allApp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        color: orderDetails.activeStatus ==
                                                "0"
                                            ? Colors.grey
                                            : orderDetails.activeStatus ==
                                                    "received"
                                                ? Colors.blue
                                                : orderDetails.activeStatus ==
                                                        "shipped"
                                                    ? Colors.orange
                                                    : orderDetails
                                                                .activeStatus ==
                                                            "delivered"
                                                        ? Colors.green
                                                        : orderDetails
                                                                    .activeStatus ==
                                                                "returned"
                                                            ? Colors.redAccent
                                                            : orderDetails
                                                                        .activeStatus ==
                                                                    "processed"
                                                                ? Colors.cyan
                                                                : Colors.red,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9, vertical: 2),
                                      child: CustomText(
                                        text: orderDetails.activeStatus == "0"
                                            ? "awaiting"
                                            : orderDetails.activeStatus ??
                                                '...loading',
                                        fontSize: 4,
                                        color: NatureColor.whiteTemp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const CustomText(
                                        text: "Store Name:",
                                        fontSize: 5,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            NatureColor.colorOutlineBorder),
                                    CustomText(
                                      text: "${orderDetails.storeName}",
                                      fontSize: 5,
                                      color: NatureColor.textFormBackColors,
                                      textDecoration:
                                          TextDecoration.underline,
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const CustomText(
                                //         text: "OTP:",
                                //         fontSize: 5,
                                //         fontWeight: FontWeight.bold,
                                //         color:
                                //             NatureColor.colorOutlineBorder),
                                //     CustomText(
                                //       text: "${orderDetails.otp}",
                                //       fontSize: 5,
                                //       color: NatureColor.textFormBackColors,
                                //     ),
                                //   ],
                                // ),
                                // const CustomText(
                                //   text: "Order Remark:",
                                //   fontSize: 5,
                                //   color: NatureColor.colorOutlineBorder,
                                //   fontWeight: FontWeight.bold,
                                // ),
                                const SizedBox(
                                  height: 3,
                                ),
                                orderDetails.activeStatus == "delivered"
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(() => AddRatingReviewScreen(
                                                productId: productId,
                                                userRating:
                                                    orderDetails.userRating,
                                                userReview: orderDetails
                                                    .userRatingComment,
                                                userImages: orderDetails
                                                    .userRatingImages,
                                              ));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              "assets/icons/ratting.png",
                                              height: h * 0.02,
                                              color: Colors.yellow.shade700,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CustomText(
                                              text: orderDetails.userRating ==
                                                      "0"
                                                  ? "Add Review"
                                                  : "Edit Review",
                                              fontSize: 4.2,
                                              fontWeight: FontWeight.w500,
                                              color: NatureColor.primary,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    orderDetails.activeStatus == "delivered" || orderDetails.activeStatus == "cancelled"
                                        ? const SizedBox()
                                        : orderDetails.isCancelable == "1" &&
                                                orderDetails
                                                        .isAlreadyCancelled ==
                                                    '0'
                                            ? InkWell(
                                                onTap: () {
                                                  cancelCustomPopup(context,
                                                      orderDetails.id);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5),
                                                      border: Border.all(
                                                          color: Colors
                                                              .redAccent
                                                              .withOpacity(
                                                                  0.4))),
                                                  child: Center(
                                                      child: Text(
                                                    "Item Cancel",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent
                                                            .withOpacity(
                                                                0.8)),
                                                  )),
                                                ),
                                              )
                                            : const SizedBox(),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    orderDetails.isReturnable == "1" &&
                                            orderDetails.activeStatus ==
                                                "delivered"
                                        ? InkWell(
                                            onTap: () {
                                              returnCustomPopup(
                                                  context, orderDetails.id);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5),
                                                  border: Border.all(
                                                      color: Colors.redAccent
                                                          .withOpacity(0.4))),
                                              child: Center(
                                                  child: Text(
                                                "Item Return",
                                                style: TextStyle(
                                                    color: Colors.redAccent
                                                        .withOpacity(0.8)),
                                              )),
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  // downloadInvoice(),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    child: Obx(() {
                      return ListTile(
                        leading: Image.asset(
                          "assets/icons/invoice.png",
                          height: 30,
                        ),
                        title: Text(
                          orderController.downloading.value
                              ? 'Downloading...'
                              : "Download Invoice",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: orderController.downloading.value
                            ? Transform.scale(
                                scale: 0.6,
                                child: const CircularProgressIndicator(),
                              )
                            : const Icon(Icons.arrow_forward_ios_rounded,
                                color: NatureColor.primary),
                        onTap: () async {
                          if (!orderController.downloading.value) {
                            await _requestPermission();
                          }
                        },
                        // Long press to view the invoice
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: NatureColor.whiteTemp,
                        border: Border.all(
                            color: NatureColor.textFormBackColors
                                .withOpacity(0.6)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Price Details:",
                            fontSize: 5,
                            color: NatureColor.allApp,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Price:",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text: "₹ ${widget.orderModelList?.total}",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Delivery Charge:",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text:
                                    "+₹ ${widget.orderModelList?.deliveryCharge}",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Promo Code Discount:",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text:
                                    "-₹ ${widget.orderModelList?.promoDiscount}",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Wallet Balance:",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                              CustomText(
                                text:
                                    "-₹ ${widget.orderModelList?.walletBalance}",
                                fontSize: 5,
                                color: NatureColor.textFormBackColors,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Total Payable:",
                                fontSize: 5,
                                color: NatureColor.allApp,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                text:
                                    "₹ ${widget.orderModelList?.totalPayable}",
                                fontSize: 5,
                                color: NatureColor.allApp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }

  void cancelCustomPopup(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Item'),
          content: const Text('Do you want to cancel item?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    orderController.cancelAndReturnApi(
                      "cancelled",
                      id,
                    );
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void returnCustomPopup(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Return Item'),
          content: const Text('Do you want to return item?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    orderController.cancelAndReturnApi(
                      "returned",
                      id,
                    );
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart Controller/cart_controller.dart';
import 'package:nature_nook_app/Controllers/Cart Controller/payment_controller.dart';
import 'package:nature_nook_app/Custom%20Widgets/customButton.dart';
import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class PlaceOrderScreen extends StatefulWidget {
  final CartController cartController;
  const PlaceOrderScreen({super.key, required this.cartController});
  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  PlaceOrderController placeOrderController = Get.put(PlaceOrderController());

  @override
  void initState() {
    placeOrderController.cartController = widget.cartController;
    Future.delayed(Duration.zero, () {
      placeOrderController.useWallet.value =
          placeOrderController.walletBalance > 0;
      placeOrderController.getPayableAmount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Constants.screen.height,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              NatureColor.scaffoldBackGround,
              NatureColor.scaffoldBackGround1,
              NatureColor.scaffoldBackGround1,
            ])),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8).copyWith(left: 12),
                        decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Preferred Delivery Date/Time",
                              fontSize: 4.5,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: Constants.largeSize * 0.12,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: 7,
                                  itemBuilder: (_, index) {
                                    return dateCell(index);
                                  }),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Obx(() {
                              if (placeOrderController.selectedDateIndex.value != 0) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: "Morning",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "Morning",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: "12-4",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "12PM to 4PM",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: "4-8",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "4PM to 8PM",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  if (placeOrderController.currentHour < 12)
                                    Row(
                                      children: [
                                        Radio(
                                            value: "Morning",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "Morning",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  if (placeOrderController.currentHour < 16)
                                    Row(
                                      children: [
                                        Radio(
                                            value: "12PM to 4PM",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "12PM to 4PM",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  if (placeOrderController.currentHour < 20)
                                    Row(
                                      children: [
                                        Radio(
                                            value: "4PM to 8PM",
                                            groupValue: placeOrderController
                                                .selectedTime.value,
                                            onChanged: (val) {
                                              placeOrderController
                                                  .selectedTime.value = val!;
                                            }),
                                        const CustomText(
                                          text: "4PM to 8PM",
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8).copyWith(left: 12),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomText(
                          text:
                              "Total Payable: ₹${placeOrderController.cartController!.totalPrice}",
                          fontSize: 4.1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8).copyWith(left: 12),
                        decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Opacity(
                                opacity: placeOrderController.checkWallet() ? 1 : 0.4,
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: placeOrderController.useWallet.value,
                                        onChanged: (bool? val) {
                                          if (placeOrderController.checkWallet()) {
                                            placeOrderController.useWallet.value =
                                                !placeOrderController.useWallet.value;
                                            placeOrderController.getPayableAmount();
                                            if (placeOrderController
                                                    .checkTotalAmountNWallet() &&
                                                placeOrderController
                                                    .useWallet.value) {
                                              placeOrderController
                                                  .selectedPaymentMethod
                                                  .value = 'Wallet';
                                            } /*val ?? false;*/
                                          }
                                        }),
                                    const CustomText(
                                      text: "Use Wallet",
                                      fontSize: 4.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              );
                            }),
                            CustomText(
                              text:
                                  "    Wallet Balance: ₹${placeOrderController.walletBalance}",
                              fontSize: 4.3,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8).copyWith(left: 12),
                        decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(10)),
                        child: Obx(() {
                          return Opacity(
                            opacity: placeOrderController.checkTotalAmountNWallet() &&
                                    placeOrderController.useWallet.value
                                ? 0.4
                                : 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Select Payment Method",
                                  fontSize: 4.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: "COD",
                                            groupValue: placeOrderController
                                                .selectedPaymentMethod.value,
                                            onChanged: (val) {
                                              if (placeOrderController
                                                      .checkTotalAmountNWallet() &&
                                                  placeOrderController
                                                      .useWallet.value) return;
                                              placeOrderController
                                                  .selectedPaymentMethod.value = val!;
                                            }),
                                        const CustomText(
                                          text: 'Cash on Delivery',
                                          fontSize: 4.2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8).copyWith(left: 12),
                        decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(10)),
                        child:  Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Order Note(optional):",
                                fontSize: 4.5,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: placeOrderController.orderNoteController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(/*borderRadius: BorderRadius.circular(10)*/),
                                    fillColor: Colors.white,
                                    hintText: 'write your order note here...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true
                                ),
                              ),
                            ],
                          ),
                      ),
                
                      const SizedBox(
                        height: 72,
                      ),
                /*
                      Obx(() {
                        return placeOrderController.isLoading.value
                            ? const SizedBox.shrink()
                            : CustomButton(
                                text: "Place Order",
                                onPressed: () {
                                  // Utils.mySnackBar(title: 'Payment Method Not Found',msg: 'Payment Method not implemented yet, coming soon',duration: const Duration(seconds: 3));
                                  placeOrderController.onPlaceOrder();
                                });
                      })*/
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return placeOrderController.isLoading.value
                    ? const SizedBox.shrink()
                    : CustomButton(
                    text: "Place Order",
                    onPressed: () {
                      // Utils.mySnackBar(title: 'Payment Method Not Found',msg: 'Payment Method not implemented yet, coming soon',duration: const Duration(seconds: 3));
                      placeOrderController.onPlaceOrder();
                    });
              })
            ],
          ),
        ),
      ),
      /*bottomSheet: Obx(() {
        return placeOrderController.isLoading.value
            ? const SizedBox.shrink()
            : Container(
                 height: 64,
              color: Colors.transparent,
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: CustomButton(
              text: "Place Order",
              onPressed: () {
                // Utils.mySnackBar(title: 'Payment Method Not Found',msg: 'Payment Method not implemented yet, coming soon',duration: const Duration(seconds: 3));
                placeOrderController.onPlaceOrder();
              }),
            );
      }),*/
    );
  }

  /// preferred date time show for delivery
  dateCell(int index) {
    placeOrderController.getStartingDate();
    DateTime today = DateTime(
        placeOrderController.startingDate.year,
        placeOrderController.startingDate.month,
        placeOrderController.startingDate.day);
    return Obx(() {
      return InkWell(
        onTap: () {
          DateTime date = today.add(Duration(days: index));
          if (mounted) placeOrderController.changeSelectedDateIndex(index);
          placeOrderController.selectedTime.value = '';
          placeOrderController.selectedDate.value =
              DateFormat('dd-MM-yyyy').format(date);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: NatureColor.primary1),
              color: placeOrderController.selectedDateIndex.value == index
                  ? NatureColor.primary1
                  : null),
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: DateFormat('EEE')
                      .format(today.add(Duration(days: index))),
                  color: placeOrderController.selectedDateIndex.value == index
                      ? NatureColor.whiteTemp
                      : NatureColor.primary2,
                  fontSize: 4.2,
                ),
                CustomText(
                  text:
                      DateFormat('dd').format(today.add(Duration(days: index))),
                  color: placeOrderController.selectedDateIndex.value == index
                      ? NatureColor.whiteTemp
                      : NatureColor.primary2,
                  fontSize: 4.2,
                ),
                CustomText(
                  text: DateFormat('MMM')
                      .format(today.add(Duration(days: index))),
                  color: placeOrderController.selectedDateIndex.value == index
                      ? NatureColor.whiteTemp
                      : NatureColor.primary2,
                  fontSize: 4.2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart Controller/cart_controller.dart';
import 'package:nature_nook_app/Screens/Cart/order_success_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class PlaceOrderController extends GetxController {
  CartController? cartController;
  RxInt selectedDateIndex = 1.obs;
  RxString selectedPaymentMethod = "".obs;
  RxString selectedDate = "".obs;
  RxString selectedTime = "".obs;
  RxBool isLoading = false.obs;
  RxBool useWallet = false.obs;
  RxNum payableAmount = RxNum(0);
  final orderNoteController = TextEditingController();

  RxDouble get walletBalance =>
      double.parse(cartController?.profileModel?.data?.balance ?? '0').obs;
  RxInt get currentHour => startingDate.hour.obs;

  bool checkWallet() {
    if (walletBalance > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool checkTotalAmountNWallet() {
    if (cartController?.cartModel?.overallAmount == null) {
      return false;
    }
    return !(cartController!.cartModel!.overallAmount! > walletBalance.value);
  }

  getStartingDate() {
    if (currentHour.value >= 20) {
      startingDate = startingDate.add(const Duration(days: 1));
    } else {
      startingDate = DateTime.now();
    }
  }

  getPayableAmount() {
    if (useWallet.value) {
      payableAmount.value =
          cartController!.cartModel!.overallAmount! - walletBalance.value;
    } else {
      payableAmount.value = cartController!.cartModel!.overallAmount!;
    }
  }

  changeSelectedDateIndex(int index) {
    selectedDateIndex.value = index;
  }

  DateTime startingDate = DateTime.now();

  Future<void> onPlaceOrder() async {
    if (selectedDate.value.isEmpty) {
      selectedDate.value = DateFormat('dd-MM-yyyy')
          .format(startingDate.add(const Duration(days: 1)));
    }
    if (selectedPaymentMethod.value.isEmpty &&
        useWallet.value &&
        !checkTotalAmountNWallet()) {
      Utils.mySnackBar(
        title: "Insufficient Wallet",
        msg: "Please select payment method",
      );
      return;
    }
    if (selectedTime.value.isEmpty) {
      Utils.mySnackBar(title: "Please select time slot");
    } else if (selectedPaymentMethod.value.isEmpty && !useWallet.value) {
      Utils.mySnackBar(title: "Please select payment method");
    } else {
      if (useWallet.value && walletBalance <= 0) return;
      Utils.showLoader();
      bool placed = await cartController!.placeOrder(selectedDate.value,
          selectedTime.value, selectedPaymentMethod.value, useWallet.value, orderNoteController.text);
      Get.close(1);
      if (placed) {
        Get.to(() => const OrderSuccessScreen());
        Get.delete<CartController>();
        Get.delete<PlaceOrderController>();
      } else {
        Utils.mySnackBar(
            title: "Something went wrong", msg: 'Please try again');
      }
    }
  }

  @override
  void onClose() {
    selectedDateIndex.value = 0;
    selectedPaymentMethod.value = "";
    selectedDate.value = "";
    selectedTime.value = "";
    // TODO: implement onClose
    super.onClose();
  }
}

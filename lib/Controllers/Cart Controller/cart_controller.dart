// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Address%20Model/address_model.dart';
import 'package:nature_nook_app/Models/Address%20Model/pincode_model.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Profile/profile_model.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Cart/cart_model.dart';
import 'package:nature_nook_app/Network%20Connectivity/connectivty_check.dart';
import 'package:nature_nook_app/Screens/Cart/promo_codes_screen.dart';
import 'package:nature_nook_app/Screens/Cart/shipping_detail_sheet.dart';
import 'package:nature_nook_app/Screens/User Profile/Manage Address/manage_address.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class CartController extends GetxController {
  ///api services instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///get api urls
  String get getProfile => apiServices.getProfile;
  String get getCartDataUrl => apiServices.getCart;
  String get addToCartUrl => apiServices.addToCart;
  String get removeFromCartDataUrl => apiServices.removeFromCart;
  String get getAddressesUrl => apiServices.getAddresses;
  String get getAllPinCodes => apiServices.getAllPinCodes;
  String get applyPromoUrl => apiServices.promoCodeApply;
  String get getPlaceOrderUrl => apiServices.placeOrder;

  ///get user id
  String get _userId => SharedPref.getUserId();

  ///declare variables
   RxBool emptyScreen = false.obs;
  CartModel? cartModel;
  ProfileModel? profileModel;
  RxBool isSignIn = true.obs;
  RxBool pageLoading = false.obs;
  RxList<PincodeData> allPinCodes = <PincodeData>[].obs;
  RxList<CartData> cartDataList = <CartData>[].obs;
  RxList<CartData> savedLaterDataList = <CartData>[].obs;
  RxList<bool> deliverableList = <bool>[].obs;
  RxList<AddressData> addresses = <AddressData>[].obs;
  AddressData? selectedAddressData;
  RxNum subTotalPrice = RxNum(0);
  RxNum totalPrice = RxNum(0);
  RxString userAddress = ''.obs;
  List<RxInt> quantities = [];
  List<RxInt> saveLaterQuantities = [];
  Rx<PromoData> selectedPromoData = Rx<PromoData>(PromoData());
  num discount = 0;


  ///get profile data
  Future getUserProfile() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getProfile), {'user_id': _userId});
    profileModel = ProfileModel.fromJson(response);
  }

  ///get cart data list
  Future<CartModel?> getCartData({bool onlyCartData = false, bool onlySaveLater = false}) async {
    emptyScreen.value = false;
    if (_userId.isEmpty) {
      isSignIn.value = false;
      cartDataList.value = [];
      cartModel = null;
      emptyScreen.value = true;
      return null;
    }
    isSignIn.value = true;
    if(onlySaveLater){
      await getSavedLaterData();
    }
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getCartDataUrl), {"user_id": _userId});
    if (response['error'] ?? true) {
      // Utils.mySnackBar(title: 'Error Found', msg: response['message']??'Something went wrong');
    }
    cartModel = CartModel.fromJson(response);
    if (cartModel == null) {
      refresh();
      return null;
    }
    cartDataList.value = cartModel!.data;
    subTotalPrice.value = cartModel!.totalArr ?? 0;
    totalPrice.value = subTotalPrice.value + cartModel!.deliveryCharge - discount ;
     // final qty = quantities;
      quantities = List.generate(cartDataList.length, (index){
        // if(qty.isNotEmpty && index < qty.length){
        //   return qty.elementAt(index);
        // }
        return int.parse(cartDataList[index].qty??'0').obs;
      });
    if (!onlyCartData) {
      await getSavedLaterData();
    }
    if(cartDataList.isEmpty && savedLaterDataList.isEmpty){
      emptyScreen.value = true;
    }
    return cartModel;
  }

  ///  get saved for later list
  getSavedLaterData() async {
    // savedLaterDataList.value = [];
    dynamic response = await apiBaseHelper.postAPICall(
        Uri.parse(getCartDataUrl),
        {"user_id": _userId, 'is_saved_for_later': '1'});
    if (response['error'] ?? true) {
      //Utils.mySnackBar(title: 'Error Found', msg: response['message']??'Something went wrong');
    }
    // cartModel = CartModel.fromJson(response);
    savedLaterDataList.value = CartModel.fromJson(response).data;
    saveLaterQuantities = List.generate(savedLaterDataList.length, (index){
      return int.parse(savedLaterDataList[index].qty??'0').obs;
    });
    // savedLaterDataList.value = cartModel!.data;
  }

  /// save for later
  Future<void> saveForLater(
      String productVariantId, String qty, String saveLater) async {
    Utils.showLoader();
    Map<String, String> param = {
      'user_id': _userId,
      'product_variant_id': productVariantId,
      'is_saved_for_later': saveLater,
      'qty': qty
    };
    await apiBaseHelper.postAPICall(Uri.parse(addToCartUrl), param);
    await getCartData();
    Get.back();
  }

  ///remove from saved for later
  Future<void> removeSaveForLater(
      String productVariantId, String qty, String saveLater) async {
    Utils.showLoader();
    Map<String, String> param = {
      'user_id': _userId,
      'product_variant_id': productVariantId,
      'is_saved_for_later': saveLater,
      'qty': qty
    };
   final response = await apiBaseHelper.postAPICall(Uri.parse(addToCartUrl), param);
   log('response $response');
    if(response['error']??true){
      Get.back();
      Utils.mySnackBar(title: 'Not removed', msg: 'something went wrong please try again');
    }else{
      await removeProductFromCart(productVariantId, '0');
      Get.back();
    }
  }

  ///update cart quantity
  Future<dynamic> updateQuantity(
      String productVariantId, String qty, String saveLater) async {
    // Utils.showLoader();
    Map<String, String> param = {
      'user_id': _userId,
      'product_variant_id': productVariantId,
      'is_saved_for_later': saveLater,
      'qty': qty
    };
    try {
      final response = await apiBaseHelper.postAPICall(Uri.parse(addToCartUrl), param);
      return response;
    }catch(e){
      return {
        'error' : true
      };
    }

    // await getCartData(onlyCartData: saveLater == '0',onlySaveLater: saveLater == '1');
    // Get.back();
  }


  // ///get total price of all products
  // getTotalPrice(){
  //   for(CartData cartData in cartDataList){
  //     totalPrice =
  //   }
  // }


  ///increase or decrease cart product quantity
  increment(int index, num productPrice,String productVariantId){
    quantities[index].value++;
    subTotalPrice.value += productPrice;
    updateQuantity(productVariantId, quantities[index].toString(), '0').then((val){
      if(val['error']??true){
        quantities[index].value--;
        subTotalPrice.value -= productPrice;
      }
    });
  }

  decrement(int index, num productPrice,String productVariantId){
    if(quantities[index].value<2 ) return;
    quantities[index].value--;
    subTotalPrice.value -= productPrice;
    updateQuantity(productVariantId, quantities[index].toString(), '0').then((val){
      if(val['error']??true){
        quantities[index].value++;
        subTotalPrice.value += productPrice;
      }
    });
  }

  ///increase or decrease save later cart data
  incrementSaveLater(int index,String productVariantId){
    saveLaterQuantities[index].value++;
    updateQuantity(productVariantId, saveLaterQuantities[index].toString(), '1').then((val){
      if(val['error']??true){
        saveLaterQuantities[index].value--;
      }
    });
  }

  decrementSaveLater(int index,String productVariantId){
    if(saveLaterQuantities[index].value<2) return;
    saveLaterQuantities[index].value--;
    updateQuantity(productVariantId, saveLaterQuantities[index].toString(), '1').then((val){
      if(val['error']??true){
        saveLaterQuantities[index].value++;
      }
    });
  }

  ///remove product from cart
  Future<void> removeProductFromCart(String productVariantId, String savedLaterStatus) async {
    if (productVariantId.isEmpty) return;
    Map<String, String> param = {
      'user_id': _userId,
      'product_variant_id': productVariantId,
      'is_saved_for_later' : savedLaterStatus,
    };
    Utils.showLoader();
    await apiBaseHelper
        .postAPICall(Uri.parse(removeFromCartDataUrl), param)
        .then((value) async {
      if (value['error'] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value['message'] ??
                'Something went wrong!,\nPlease try again later');
      } else {
        await getCartData();
      }
    }, onError: (e) {});
    Get.back();
  }

  ///get users addresses list
  Future getAddressesList() async {
    addresses.value = [];
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getAddressesUrl), {"user_id": _userId});
    // if(response['error']??true && (response['message']??'' != 'No Details Found!')){
    //   Utils.mySnackBar(title: 'Error Found', msg: response['message']??'Something went wrong');
    //   return;
    // }else {
    addresses.value = AddressModel.fromJson(response).data;
    // }
    getDefaultAddress();
  }

  ///get default address from the addresses
  getDefaultAddress() {
    userAddress.value = '';
    selectedAddressData = null;
    if (addresses.isEmpty) return;
    selectedAddressData =
        addresses.where((addressData) => addressData.isDefault == "1").first;
    selectedAddressData ??= addresses.first;
    userAddress.value = getUserAddress(selectedAddressData!);
  }

  ///get the user address value in string
  String getUserAddress(AddressData addressData) {
    return '${addressData.name}, ${addressData.address}, ${addressData.city}, ${addressData.state}, ${addressData.country}, ${addressData.pincode},\ntype: ${addressData.type}, mobile: ${addressData.mobile}';
  }

  ///get deliverable pin codes
  Future getAllPins() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(getAllPinCodes), {});
    allPinCodes.value = PincodeModel.fromJson(response).data;
  }

  ///check if product is deliverable at selected pin code
  bool checkIsDeliverablePincode(int index) {
    String deliverableType =
        cartDataList[index].productDetails.first.deliverableType ?? '';
    if (deliverableType == '0') {
      deliverableList[index] = false;
      return false;
    } else if (deliverableType == '1') {
      deliverableList[index] = true;
      return true;
    } else if (deliverableType == '2') {
      List<String> pinIds =
          (cartDataList[index].productDetails.first.deliverableZipcodesIds ??
                  '')
              .split(",");
      List<String> deliverablePinCodes = [];
      for (String pinId in pinIds) {
        String? pin =
            allPinCodes.firstWhere((pinData) => pinId == pinData.id).zipcode;
        if (pin != null) {
          deliverablePinCodes.add(pin);
        }
      }
      log("pin codes $pinIds");
      deliverableList[index] =
          deliverablePinCodes.contains(selectedAddressData?.pincode);
      return deliverableList[index];
    } else if (deliverableType == '3') {
      List<String> pinIds =
          (cartDataList[index].productDetails.first.deliverableZipcodesIds ??
                  '')
              .split(",");
      List<String> deliverablePinCodes = [];
      for (String pinId in pinIds) {
        String? pin =
            allPinCodes.firstWhere((pinData) => pinId == pinData.id).zipcode;
        if (pin != null) {
          deliverablePinCodes.add(pin);
        }
      }
      log("pin codes $pinIds");
      deliverableList[index] =
          !deliverablePinCodes.contains(selectedAddressData?.pincode);
      return deliverableList[index];
    } else {
      return false;
    }

    // dynamic response = await apiBaseHelper.postAPICall(
    //     Uri.parse(checkDeliverable),
    //     {'product_id': 15, 'zipcode': selectedAddressData?.pincode ?? ''});
  }

  // List<String> variantIds = [];
  // List<String> allQuantities = [];
  //
  // ///get quantities and variant ids
  // Future getQuantitiesNVariantIds() async {
  //   variantIds = [];
  //   allQuantities = [];
  //   for (CartData cartData in cartDataList) {
  //     variantIds.add(cartData.productVariantId.toString());
  //     allQuantities.add(cartData.qty.toString());
  //   }
  // }

  ///on check out method
  Future<void> onCheckOut(cartController) async {
    if(!(await NetworkConnectivityService.checkInternetConnection())) {
      Utils.mySnackBar(title: 'No internet', msg: 'Check your internet connection');
      return;
    }
    deliverableList = List.generate(cartDataList.length, (index) => true).obs;
    Utils.showLoader();
    selectedPromoData.value = PromoData();
    await getAddressesList();
    await getUserProfile();
    await getAllPins();
    await getCartData(onlyCartData: true);
    Get.back();
    Get.bottomSheet(
      ShippingDetailSheet(cartController: cartController),
      isScrollControlled: true,
    );
  }


 /// apply promo code
  String? promoInvalidMessage;
  Future<void> applyPromoCode() async {
    if(cartModel == null){
      await getCartData(onlyCartData: true);
    }
    final PromoData? result = (await Get.to(()=>PromoCodeScreen(promoCodes: cartModel!.promoCodes,promoCode: selectedPromoData.value.promoCode??'',)));
    if(result != null) {
      if(result.promoCode == null) {
        selectedPromoData.value = result;
        promoInvalidMessage = null;
        discount =0;
        totalPrice.value = subTotalPrice.value +cartModel!.deliveryCharge - discount;
        return;
      }
      Utils.showLoader();
      final response = await apiBaseHelper.postAPICall(
        Uri.parse(applyPromoUrl),
        {
          'user_id': _userId,
          'promo_code': result.promoCode!,
          'final_total':cartModel?.subTotal,
        }
      );
      log("response promo $response");
      Get.back();
      if(response['error']??true){
        promoInvalidMessage = response['message']??'';
        discount = 0;
        totalPrice.value = subTotalPrice.value +cartModel!.deliveryCharge -discount;
      }
      else{
        promoInvalidMessage = null;
        if(result.isCashback == '1'){
          discount = 0;
        }
        else if(result.discountType == 'amount'){
          discount = result.discount??0;
        }
        /*else if(result.discountType =='percentage'){
          discount = subTotalPrice.value * (result.discount??0)/100;
        }*/
        else {
          discount = subTotalPrice.value * (result.discount??0)/100;
        }
        totalPrice.value = subTotalPrice.value +cartModel!.deliveryCharge -discount;
      }
      selectedPromoData.value = result;
    }
  }

///get promo discount type
  String getPromoCodeAppliedText() {
    if(selectedPromoData.value.promoCode != null){
      switch(selectedPromoData.value.discountType){
        case 'amount':
          if(selectedPromoData.value.isCashback == '1'){
            return '₹${selectedPromoData.value.discount ?? ''}  cashback applied';
          }
          return '₹${selectedPromoData.value.discount ?? ''}  discount applied';
        case 'percentage':
          if(selectedPromoData.value.isCashback == '1'){
            return '${selectedPromoData.value.discount ?? ''}%  cashback applied';
          }
          return '${selectedPromoData.value.discount ?? ''}%  discount applied';
        default:
          return '';
      }
    }
    return '';
  }

  ///place order after selection of date time and payment method
  Future<bool> placeOrder(

      String date, String time, String paymentMethod, bool useWallet, String orderNote) async {
    if(!(await NetworkConnectivityService.checkInternetConnection())) {
      Utils.mySnackBar(title: 'No internet', msg: 'Check your internet connection');
      return false;
    }
    if (cartModel == null) {
      await getCartData(onlyCartData: true);
    }
    String walletAmount = '0';
    if (useWallet) {
      if (cartModel!.totalArr! >
          double.parse(profileModel?.data?.balance ?? "0")) {
        walletAmount = profileModel!.data!.balance ?? "0";
      } else {
        walletAmount = cartModel!.overallAmount!.toString();
      }
      if (walletAmount == '0') {
        return false;
      }
    }
    // await getQuantitiesNVariantIds();
    Map<String, String> param = {
      'user_id': _userId,
      'mobile': selectedAddressData!.mobile ?? '',
      'email': 'testmail123@gmail.com',
      'product_variant_id': cartModel!.variantId.join(','),
      'quantity': quantities.join(','),
      'total': totalPrice.value.toString(),
      'delivery_charge': cartModel!.deliveryCharge.toString(),
      'tax_amount': cartModel!.taxAmount.toString(),
      'tax_percentage': cartModel!.taxPercentage.toString(),
      'final_total': subTotalPrice.value.toString(),
      'latitude': selectedAddressData!.latitude.toString(),
      'longitude': selectedAddressData!.longitude.toString(),
      'promo_code': selectedPromoData.value.promoCode??'',
      'payment_method': paymentMethod,
      'address_id': selectedAddressData!.id.toString(),
      'delivery_date': date,
      'delivery_time': time,
      'is_wallet_used': useWallet ? '1' : '0',
      'wallet_balance_used': walletAmount,
      'active_status': '0',
      'order_note': orderNote,
    };
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(getPlaceOrderUrl), param);
    if (response['error'] ?? true) {
      Utils.mySnackBar(
          title: 'Error Found',
          msg: response['message'] ?? 'Something went wrong, Please try again',
          duration: const Duration(seconds: 3));
      return false;
    } else {
      Utils.mySnackBar(
          title: 'Order Placed',
          msg: 'Your Order Placed Successfully',
          duration: const Duration(seconds: 1));
      return true;
    }
  }

  ///on Change Shipping Address
  Future<void> onChangeShippingAddress(cartController) async {
    Get.back();
    final AddressData? changedAddressData =
        await Get.to(() => ManageAddressScreen(
              addressId: selectedAddressData?.id ?? 'add',
            ));
    Get.bottomSheet(
      ShippingDetailSheet(cartController: cartController),
      isScrollControlled: true,
    );
    if (changedAddressData != null) {
      selectedAddressData = changedAddressData;
      userAddress.value = getUserAddress(selectedAddressData!);
    } else {
      getAddressesList();
    }
  }

  @override
  Future<dynamic> refresh() async {
    CartModel? cartModel = await getCartData();
    return cartModel;
  }
}

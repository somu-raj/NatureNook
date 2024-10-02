// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Address Model/address_model.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class ProductController extends GetxController {
  ///api services instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///get user id
  String get _userId => SharedPref.getUserId();

  ///get api urls
  String get getProductsUrl => apiServices.getProducts;
  String get getAddressesUrl => apiServices.getAddresses;
  String get checkDeliverable => apiServices.checkDeliverable;
  String get getPlaceOrderUrl => apiServices.placeOrder;
  String get addToCartUrl => apiServices.addToCart;

  ///declare variables
  RxBool isLoading = false.obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<RxInt> counters = List<RxInt>.filled(1, 0.obs).obs;
  RxInt productCounter = 1.obs;
  Product? productObserver;
  RxInt pageIndex = 0.obs;
  RxInt variantIndex = 0.obs;
  RxBool showAllDescription = false.obs;
  RxList<RxBool> isFavoritedList = List<RxBool>.filled(1, false.obs).obs;
  RxBool pageLoading = false.obs;
  RxBool deliverable = false.obs;
  final pinCodeController = TextEditingController(text: 'Enter Pincode');
  final pincodeFormKey = GlobalKey<FormState>();

  ///get products list category wise
  getProductsList(String key, String id) async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(getProductsUrl), {key: id});
    productList.value = ProductsModel.fromJson(response).data;
    getCountersNFavoriteList();
  }

  /// get the counters and the favorite list according to the the length of the products
  void getCountersNFavoriteList() {
    counters.value = List<RxInt>.filled(productList.length, 0.obs);
    isFavoritedList.value = List<RxBool>.filled(productList.length, false.obs);
  }

  ///update the product quantity
  void updateProductQuantity(index) {
    if (counters[index] > 1) {
      productCounter = counters[index];
    } else {
      productCounter.value = 1;
    }
  }

  ///increment count of product quantity
  void incrementCounter(int index) {
    counters[index].value++;
  }

  void incrementProductCounter() {
    productCounter.value++;
  }

  ///decrement count of product quantity
  void decrementCounter(int index) {
    if (counters[index].value > 0) {
      counters[index].value--;
    }
  }

  void decrementProductCounter() {
    if (productCounter.value > 1) {
      productCounter.value--;
    }
  }

  /// toggle add to wishlist functionality
  void toggleFavorite(int index) {
    isFavoritedList[index].value = !isFavoritedList[index].value;
  }

  ///update product Observer
  updateProductObserver(Product product) {
    productObserver = product;
    checkIsDeliverable();
  }

  ///get users addresses list
  Future getAddressesList() async {
    isLoading.value = true;
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getAddressesUrl), {"user_id": _userId});
    isLoading.value = false;
    pinCodeController.text = AddressModel.fromJson(response)
            .data
            .where((addressData) => addressData.isDefault == "1")
            .first
            .pincode ??
        '';
    checkIsDeliverable();
  }

  ///check deliverable pin code
  Future<void> checkIsDeliverable() async {
    isLoading.value = true;
    if (productObserver?.deliverableType == '1') {
      deliverable.value = true;
      isLoading.value = false;
      return;
    } else if (productObserver?.deliverableType == '0') {
      deliverable.value = false;
      isLoading.value = false;
      return;
    }
    Map<String, String> param = {
      'product_id': productObserver?.id ?? '',
      'zipcode': pinCodeController.text,
    };
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(checkDeliverable), param);
    isLoading.value = false;
    deliverable.value = !(response['error'] ?? true);
  }

  ///add to cart method
  Future<void> addToCart() async {
    final bool isLoggedIn = SharedPref.getLogin();
    final userId = SharedPref.getUserId();
    if (!isLoggedIn || userId.isEmpty) {
      Get.back();
      Utils.mySnackBar(title: 'Login', msg: 'Please sign in to continue');
      Get.to(() => const LoginScreen(
            canPop: true,
          ));
      Get.delete<ProductController>();
      return;
    }
    if (productCounter.value < 1) {
      Get.back();
      Utils.mySnackBar(
          title: 'Add Quantity', msg: 'Please add minimum 1 quantity');
      return;
    }
    isLoading.value = true;
    Map<String, String> param = {
      'user_id': userId,
      'product_variant_id':
          productObserver?.variants[variantIndex.value].id ?? '',
      /*'is_saved_for_later': 1,*/
      'qty': productCounter.value.toString()
    };
    await apiBaseHelper.postAPICall(Uri.parse(addToCartUrl), param).then(
        (value) {
      if (value['error'] ?? true) {
        Get.back();
        Utils.mySnackBar(
            title: "Error Found",
            msg: value['message'] ??
                'Something went wrong!,\nPlease try again later');
      } else {
        Get.back();
        Utils.mySnackBar(
          title: "Product Added to Cart",
          msg: '...going to cart',
        );
        Get.to(() => const DashboardScreen(selectedIndex: 2));
        Get.delete<ProductController>();
      }
    }, onError: (e) {
      Get.back();
      Utils.mySnackBar(title: "Error Found!!", msg: e.toString());
    });
    isLoading.value = false;
  }

  @override
  Future<void> refresh({String key = "", String id = ""}) async {
    await getProductsList(key, id);
  }
}

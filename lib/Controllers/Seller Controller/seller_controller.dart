// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';

class SellerController extends GetxController {
  // ///api services instance
  // ApiServices apiServices = ApiServices();
  // ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  // ///get api urls
  // String get getProductsUrl => apiServices.getProducts;
  // String get addToCartUrl => apiServices.addToCart;

  ///declare variables
  RxBool isLoading = false.obs;
  RxInt currentIndex = 0.obs;
  RxBool isGridView = true.obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<RxInt> counters = List<RxInt>.filled(1, 0.obs).obs;
  RxList<RxBool> isFavoritedList = List<RxBool>.filled(1, false.obs).obs;

  ///update currentIndex
  updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

  ///toggle grid view or list view
  toggleGridOrList() {
    isGridView.value = !isGridView.value;
  }

  // ///update the product quantity
  // void updateProductQuantity(index) {
  //   if (counters[index] > 1) {
  //     productCounter = counters[index];
  //   } else {
  //     productCounter.value = 1;
  //   }
  // }

  // ///increment count of product quantity
  // void incrementCounter(int index) {
  //   counters[index].value++;
  // }

  // ///decrement count of product quantity
  // void decrementCounter(int index) {
  //   if (counters[index].value > 0) {
  //     counters[index].value--;
  //   }
  // }

  // /// toggle add to wishlist functionality
  // void toggleFavorite(int index) {
  //   isFavoritedList[index].value = !isFavoritedList[index].value;
  // }

  @override
  Future<void> refresh({String catId = ""}) async {}
}

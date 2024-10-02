// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api%20Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api%20Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Home/category_model.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Home/slider_model.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Home/brand_model.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Home/sections_model.dart';
import 'package:nature_nook_app/Screens/Product/products_list_screen.dart';
import 'package:nature_nook_app/Screens/Seller/seller_detail.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';

class HomeController extends GetxController {
  /// get user id
  String get userId => SharedPref.getUserId();

  ///controller for search
  TextEditingController searchProductController = TextEditingController();

  /// api services and helper methods instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///api urls
  String get sliderUrl => apiServices.getSliderImages;
  String get categoryUrl => apiServices.getCategory;
  String get allBrandsUrl => apiServices.getBrands;
  String get getSectionsUrl => apiServices.getSections;

  ///home data lists
  RxList<SliderModelData> sliderData = <SliderModelData>[].obs;
  RxList<CatData> catListData = <CatData>[].obs;
  RxList<BrandData> allBrandsList = <BrandData>[].obs;
  RxList<SectionData> sections = <SectionData>[].obs;

  ///variables
  RxInt sliderIndex = 0.obs;

  ///get all banner images
  getSliderModel() async {
    dynamic response = await apiBaseHelper.getAPICall(Uri.parse(sliderUrl));
    sliderData.value = SliderModel.fromJson(response).data;
  }

  ///get all categories of products
  getCategoryModel() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(categoryUrl), {});
    catListData.value = CategoryModel.fromJson(response).data;
  }

  ///get all brands of products
  getAllBrandsModel() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(allBrandsUrl), {});
    allBrandsList.value = BrandModel.fromJson(response).data;
  }

  ///get all brands of products
  getSectionsModel() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(getSectionsUrl), {});
    sections.value = SectionModel.fromJson(response).data;
  }

  //go to other screens
  ///go to Products listing screen category wise
  void goToProductsList(String catId) {
    if (catId.isEmpty) return;
    Get.to(() => ProductListScreen(
          kKey: 'category_id',
          id: catId,
        ));
  }

  /// go to seller details screen
  void goToSellerDetailScreen(BrandData sellerData) {
    if ((sellerData.sellerId ?? '').isEmpty) return;
    Get.to(() => SellerDetails(
          seller: sellerData,
        ));
  }

  @override
  Future<void> refresh() async {
    await getSliderModel();
    await getCategoryModel();
    await getSectionsModel();
    await getAllBrandsModel();
  }
}

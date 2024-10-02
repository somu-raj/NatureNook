// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Home/category_model.dart';
import 'package:nature_nook_app/Screens/Product/products_list_screen.dart';

class CategoryController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get sliderUrl => apiServices.getSliderImages;
  String get categoryUrl => apiServices.getCategory;
  RxList<CatData> catListData = <CatData>[].obs;
  RxBool pageLoading = false.obs;

  ///get categories of products
  getCategoryModel() async {
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(categoryUrl), {});
    catListData.value = CategoryModel.fromJson(response).data;
  }

  ///go to Products listing screen category wise
  void goToProductsList(String catId) {
    if (catId.isEmpty) return;
    Get.to(() => ProductListScreen(
          kKey: 'category_id',
          id: catId,
        ));
  }

  @override
  Future<void> refresh() async {
    await getCategoryModel();
  }
}

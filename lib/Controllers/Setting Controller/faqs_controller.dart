// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Settings/get_faqs_model.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';

class FaqsController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get getFaqsUrl => apiServices.getFaqs;
  RxList<FaqsDataList> faqListData = <FaqsDataList>[].obs;
  RxBool pageLoading = false.obs;

  ///get user id from preferences
  String get _userId => SharedPref.getUserId();

  ///get categories of products
  getFaqsModel() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getFaqsUrl), {'user': _userId});
    faqListData.value = GetFaqsModel.fromJson(response).data;
  }

  @override
  Future<void> refresh() async {
    await getFaqsModel();
  }
}

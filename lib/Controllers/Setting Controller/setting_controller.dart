// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Settings/get_faqs_model.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Settings/get_setting_model.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';

class SettingController extends GetxController {
  ///on controller close
  @override
  void onClose() {
    super.onClose();
  }

  ///get user id from preferences
  String get userId => SharedPref.getUserId();

  /// network connectivity services

  /// api services and helper methods instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///api urls
  String get getSetting => apiServices.getSetting;

  RxList<FaqsDataList> faqsData = <FaqsDataList>[].obs;

  GetSettingModel? getSettingModel;

  ///get setting api
  getUserSetting() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getSetting), {'user_id': userId});
    getSettingModel = GetSettingModel.fromJson(response);
  }

  @override
  Future<void> refresh() async {
    await getUserSetting();
  }
}

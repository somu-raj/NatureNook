// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Notification/notification_model.dart';

import '../../Utils/shared_preferences.dart';

class NotificationController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get getNotificationURL => apiServices.getNotification;
  RxList<NotificationData> notificationData = <NotificationData>[].obs;
  RxBool pageLoading = false.obs;

  ///get user id from preferences
  String get _userId => SharedPref.getUserId();
  /// getNotification api
  getNotification() async {

    dynamic response =
    await apiBaseHelper.postAPICall(Uri.parse(getNotificationURL),{"user_id":_userId});
    notificationData.value = NotificationModel.fromJson(response).data;
  }

  @override
  Future<void> refresh() async {
    await getNotification();
  }
}

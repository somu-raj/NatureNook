// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api%20Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api%20Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Rating/rating_model.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class RatingController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  double currentRating = 0.0;
  final ratingTextController = TextEditingController();
  RxBool pageLoading = false.obs;

  String get addRating => apiServices.addRating;
  String get getRating => apiServices.getRating;
  var isLoading = false.obs;
  RxList<RatingList> ratingList = <RatingList>[].obs;

  ///get user id
  String get userId => SharedPref.getUserId();

  ///  api add rating
  addRatingApi(
      List<File> images, String productId, List<String> userImages) async {
    isLoading.value = true;
    try {
      final response = await ApiBaseHelper().postMultipartAPICall(
        Uri.parse(addRating),
        {
          "user_id": userId,
          "comment": ratingTextController.text,
          "rating": currentRating.toString(),
          "product_id": productId
        },
        fileKey: "images[]",
        files: images,
      );

      log("Response: $response");
      isLoading.value = false;

      if (response["error"] ?? true) {
        Utils.mySnackBar(
          title: "Error Found",
          msg: response["message"] ?? "Something went wrong, please try again",
        );
      } else {
        Get.to(() => const DashboardScreen(
              selectedIndex: 0,
            ));

        // Get.back();
      }
    } catch (error) {
      isLoading.value = false;
      Utils.mySnackBar(title: "Error", msg: error.toString());
    }
  }

  ///get order api
  getRatingApi(String productId) async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getRating), {"product_id": productId});
    ratingList.value = RatingModel.fromJson(response).data;
  }
  /* @override
  Future<void> refresh() async {
    await getRatingApi(productId);
  }*/
}

// Package imports:
import 'dart:developer';
import 'dart:io';


import 'package:get/get.dart';
import 'package:html_to_pdf/html_to_pdf.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/My Order/get_order_model.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class OrderController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get getOrderURL => apiServices.getOrder;
  String get cancelReturnItemURL => apiServices.cancelReturnItem;
  RxList<OrderDetailModel> orderList = <OrderDetailModel>[].obs;
  RxBool pageLoading = false.obs;

  ///get user id
  String get userId => SharedPref.getUserId();

  ///get order api
  getOrderModel() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getOrderURL), {"user_id": userId.toString()});
    orderList.value = OrderModel.fromJson(response).data;
  }

  ///return and cancel order api
  cancelAndReturnApi(status, orderId) async {
    dynamic response = await apiBaseHelper.postAPICall(
        Uri.parse(cancelReturnItemURL),
        {"status": status.toString(), "order_id": orderId.toString()});
    getOrderModel();
    orderList.value = OrderModel.fromJson(response).data;

    if(status == "returned" ){
      Utils.mySnackBar(
          title: "Order Return ",
          msg: 'Odder returned successfully',
          maxWidth: 200);
    }else{
      Utils.mySnackBar(
          title: "Order Cancel ",
          msg: 'Odder cancel successfully',
          maxWidth: 200);
    }
    //Get.back();
  }

  RxBool  downloading = false.obs;
  ///download invoice method
  Future<String> downloadInvoice(String orderId, String html ) async {
    try {
      String? targetPath;
      if (Platform.isIOS) {
        final directory  = await getApplicationDocumentsDirectory();
        targetPath = directory.path.toString();
      } else {
        Directory? directory =
        Directory('/storage/emulated/0/Download');
        if(!await directory.exists()){
           directory =
          await getExternalStorageDirectory();
        }
        targetPath = directory!.path.toString();
      }
      // String filePath = '$targetPath/$orderId.pdf';
      String targetFileName = 'naturenook_invoice_$orderId';
      // File file = File(filePath);
      final generatedPdfFile =
      await HtmlToPdf.convertFromHtmlContent(htmlContent: html,
          printPdfConfiguration: PrintPdfConfiguration(
            targetDirectory: targetPath,
            targetName: targetFileName,
            printSize: PrintSize.A4,
            printOrientation: PrintOrientation.Portrait,
          ),
      );
      final filePath = generatedPdfFile.path;
      log('filepath $filePath');
        return filePath;
    } catch (e) {
      log("error --> $e");
      Utils.mySnackBar(title: "Failed to download invoice");
      return '';
    }
  }

  /*
  ///go to Products listing screen category wise
  void goToProductsList(String catId){
    if(catId.isEmpty)return;
    Get.to(()=> ProductListScreen(catId: catId,));
  }*/

  @override
  Future<void> refresh() async {
    await getOrderModel();
  }
}

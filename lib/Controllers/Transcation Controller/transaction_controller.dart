// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Settings/transcation_model.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';

class TransactionController extends GetxController {
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String get getTransactionURL => apiServices.getTransaction;
  RxList<TransactionList> transactionListData = <TransactionList>[].obs;
  RxBool pageLoading = false.obs;

  ///get user id from preferences
  String get _userId => SharedPref.getUserId();

  ///get transaction
  getTransactionModel() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getTransactionURL), {'user_id': _userId});
    transactionListData.value = TransactionModel.fromJson(response).data;
  }

  @override
  Future<void> refresh() async {
    await getTransactionModel();
  }
}

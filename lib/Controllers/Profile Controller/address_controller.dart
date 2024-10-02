// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Address%20Model/address_model.dart';
import 'package:nature_nook_app/Models/Address%20Model/postoffice_model.dart';
import 'package:nature_nook_app/Screens/User Profile/Manage Address/add_address_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

class AddressController extends GetxController {
  ///api services instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  /// api urls
  String get getAddressesUrl => apiServices.getAddresses;
  String get getPostOfficesDataUrl => apiServices.getPostOfficesData;
  String get addNewAddressUrl => apiServices.addNewAddress;
  String get deleteAddressUrl => apiServices.deleteAddress;
  String get updateAddressUrl => apiServices.updateAddress;

  ///get user id
  String get _userId => SharedPref.getUserId();

  ///declaration of variables
  LocationPermission locationPermission = LocationPermission.denied;
  Position? _currentPosition;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  RxString addressType = 'Home'.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  RxBool pageLoading = false.obs;
  RxString userAddress = ''.obs;
  String updateAddressId = '';
  RxList<AddressData> addressesData = <AddressData>[].obs;

  ///get addresses of user
  getAddressModel() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getAddressesUrl), {'user_id': _userId});
    addressesData.value = AddressModel.fromJson(response).data;
  }

  ///get default address from the addresses
  getDefaultAddress() {
    AddressData defaultAddressData = addressesData
        .where((addressData) => addressData.isDefault == "1")
        .first;
    userAddress.value = getUserAddress(defaultAddressData);
  }

  /// get user full address from address data
  String getUserAddress(AddressData addressData) {
    return '${addressData.address}, ${addressData.city}, ${addressData.state}, ${addressData.country}, ${addressData.pincode}';
  }

  ///check for location permissions
  Future<bool> checkLocationPermission() async {
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        Utils.mySnackBar(
            title: "Location Permission Required",
            msg: "Please provide location permission",
            duration: const Duration(seconds: 10));
        return false;
      }
    }
    return true;
  }

  ///get users current position
  Future<void> getCurrentLocation() async {
    bool permissionAllowed = await checkLocationPermission();
    if (!permissionAllowed) return;
    _currentPosition = await Geolocator.getCurrentPosition();
    log("current position $_currentPosition");
  }

  ///pick address from the map
  Future<void> pickAddress() async {
    // final  address = await Get.to( () => PlacePicker(
    //   apiKey:  Platform.isAndroid
    //       ? ""
    //       : "",
    //   initialPosition: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
    //   useCurrentLocation: true,
    //   onPlacePicked: (result){
    //     log("result --> $result");
    //     Get.back();
    //   },
    // ));
    // log("address --> $address");
  }

  ///checker if add address from the shipping details screen
  bool changeAddress = false;

  /// add new address method
  Future<void> goToAddAddressScreen(addressController) async {
    addressType.value = 'Home';
    nameController.text = '';
    phoneController.text = '';
    alternatePhoneController.text = '';
    this.addressController.text = '';
    landmarkController.text = '';
    areaController.text = '';
    cityController.text = '';
    pinCodeController.text = '';
    stateController.text = '';
    countryController.text = '';
    updateAddressId = '';
    await Get.to(() => AddAddressScreen(
          addressController: addressController,
          update: false,
        ));
  }

  PostOffice? postOffice;

  ///get post offices information from pincode
  Future<bool> getPostOfficesData(String pinCode) async {
    cityController.text = '';
    stateController.text = '';
    countryController.text = '';
    Utils.showLoader();
    dynamic response = await apiBaseHelper
        .getAPICall(Uri.parse(getPostOfficesDataUrl + pinCode));
    Get.back();
    if (response['Status'] == 'Error') {
      Utils.mySnackBar(
          title: 'Incorrect Pin Code',
          msg: response['Message'] ?? 'Something went wrong!');
      return false;
    } else {
      postOffice = PostOfficeModel.fromJson(response).postOffices.last;
      cityController.text =
          postOffice?.circle == 'NA' ? '' : postOffice?.circle ?? '';
      stateController.text = postOffice?.state ?? '';
      countryController.text = postOffice?.country ?? '';
      return true;
    }
  }

  Future<void> addNewAddress() async {
    if (formKey.currentState!.validate()) {
      if (stateController.text.trim() != (postOffice?.state ?? '').trim()) {
        Utils.mySnackBar(
            title: 'Incorrect Pincode',
            msg: 'Please Enter Correct state or Pincode');
      } else if (countryController.text.trim() !=
          (postOffice?.country ?? '').trim()) {
        Utils.mySnackBar(
            title: 'Incorrect Pincode',
            msg: 'Please Enter Correct Country or Pincode');
      }
      bool isDefault = await Utils.showConfirmDialog(
          "Default", 'Make this address your default address?');
      Utils.showLoader();
      Map<String, dynamic> param = {
        'user_id': _userId,
        'type': addressType.value,
        'name': nameController.text,
        'country_code': '+91',
        'mobile': phoneController.text,
        'alternate_mobile': alternatePhoneController.text,
        'address': addressController.text,
        'landmark': landmarkController.text,
        'area_id': "1",
        'city_id': "1",
        'pincode': pinCodeController.text,
        'state': stateController.text,
        'country': countryController.text,
        'is_default': isDefault ? "1" : "0",
      };

      dynamic response =
          await apiBaseHelper.postAPICall(Uri.parse(addNewAddressUrl), param);
      if (response['error'] ?? true) {
        Get.back();
        Utils.mySnackBar(
            title: 'Error Found',
            msg: response['message'] ?? 'Something went wrong please try again',
            duration: const Duration(seconds: 3));
      } else {
        Get.back();
        AddressData newAddressData = AddressModel.fromJson(response).data.first;
        if (changeAddress) {
          Get.back();
          Get.back(result: newAddressData);
        } else {
          Get.back();
          Utils.mySnackBar(
              title: 'Success',
              msg: 'new address successfully',
              duration: const Duration(seconds: 2));
          addressesData.add(newAddressData);
          getAddressModel();
        }
      }
    } else {
      Utils.mySnackBar(
          title: 'Empty Fields',
          msg: 'Please fill all the required fields',
          duration: const Duration(seconds: 2));
    }
  }

  ///delete address
  deleteAddress(String addressId) async {
    Utils.showLoader();
    await apiBaseHelper.postAPICall(
        Uri.parse(deleteAddressUrl), {'id': addressId}).then((value) async {
      if (value['error'] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value['message'] ??
                'Something went wrong!,\nPlease try again later');
      } else {
        await getAddressModel();
      }
      Get.back();
    }, onError: (e) {
      Get.back();
    });
  }

  ///mark as default
  Future<void> markDefault(String addressId) async {
    if (addressId.isEmpty) return;
    Map<String, String> param = {
      'id': addressId,
      'is_default': "1",
    };
    Utils.showLoader();
    dynamic response =
        await apiBaseHelper.postAPICall(Uri.parse(updateAddressUrl), param);
    if (response['error'] ?? true) {
      Get.back();
      Utils.mySnackBar(
          title: 'Error Found',
          msg: response['message'] ?? 'Something went wrong please try again',
          duration: const Duration(seconds: 2));
    } else {
      Get.back();
      Utils.mySnackBar(
          title: 'Success',
          msg: 'address marked as default',
          duration: const Duration(seconds: 1));
      getAddressModel();
    }
  }

  ///update the address
  Future<void> goToUpdateAddress(
      AddressData addressData, addressController) async {
    updateAddressId = addressData.id ?? '';
    addressType.value = addressData.type ?? '';
    nameController.text = addressData.name ?? '';
    phoneController.text = addressData.mobile ?? '';
    alternatePhoneController.text = addressData.alternateMobile ?? '';
    this.addressController.text = addressData.address ?? '';
    landmarkController.text = addressData.landmark ?? '';
    areaController.text = addressData.area ?? '';
    cityController.text = addressData.city ?? '';
    pinCodeController.text = addressData.pincode ?? '';
    stateController.text = addressData.state ?? '';
    countryController.text = addressData.country ?? '';
    await Get.to(() => AddAddressScreen(
          addressController: addressController,
          update: true,
        ));
  }

  Future<void> updateAddress() async {
    if (formKey.currentState!.validate()) {
      if (stateController.text.removeAllWhitespace !=
          (postOffice?.state ?? "").removeAllWhitespace) {
        Utils.mySnackBar(
            title: 'Incorrect Pincode',
            msg: 'Please Enter Correct state or Pincode');
        return;
      } else if (countryController.text.removeAllWhitespace !=
          (postOffice?.country ?? '').removeAllWhitespace) {
        Utils.mySnackBar(
            title: 'Incorrect Pincode',
            msg: 'Please Enter Correct Country or Pincode');
        return;
      }
      bool isDefault = await Utils.showConfirmDialog(
          "Default", 'Make this address your default address?');
      Map<String, String> param = {
        'id': updateAddressId,
        'type': addressType.value,
        'name': nameController.text,
        'country_code': '+91',
        'mobile': phoneController.text,
        'alternate_mobile': alternatePhoneController.text,
        'address': addressController.text,
        'landmark': landmarkController.text,
        'area_id': "1",
        'city_id': "1",
        'pincode': pinCodeController.text,
        'state': stateController.text,
        'country': countryController.text,
        'is_default': isDefault ? "1" : "0",
      };
      Utils.showLoader();
      dynamic response =
          await apiBaseHelper.postAPICall(Uri.parse(updateAddressUrl), param);
      log('edit response $response');
      if (response['error'] ?? true) {
        Get.back();
        Utils.mySnackBar(
            title: 'Error Found',
            msg: response['message'] ?? 'Something went wrong please try again',
            duration: const Duration(seconds: 3));
      } else {
        Get.back();
        AddressData updatedAddressData =
            AddressModel.fromJson(response).data.first;
        if (changeAddress) {
          Get.back();
          Get.back(result: updatedAddressData);
        } else {
          Get.back();
          Utils.mySnackBar(
              title: 'Success',
              msg: 'address updated successfully',
              duration: const Duration(seconds: 2));
          getAddressModel();
        }
      }
    } else {
      Utils.mySnackBar(
          title: 'Empty Fields',
          msg: 'Please fill all the required fields',
          duration: const Duration(seconds: 2));
    }
  }

  ///on controller close
  @override
  void onClose() {
    alternatePhoneController.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    super.onClose();
  }

  @override
  Future<void> refresh() async {
    await getAddressModel();
  }
}

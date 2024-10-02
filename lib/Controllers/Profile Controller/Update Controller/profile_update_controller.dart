// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Api Services/api_helper_methods.dart';
import 'package:nature_nook_app/Api Services/api_services.dart';
import 'package:nature_nook_app/Models/Dashboard Models/Profile/profile_model.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';

import '../../../Custom Widgets/customButton.dart';
import '../../../Custom Widgets/customTextFormField.dart';
import '../../../Screens/auth/login_screen.dart';
import '../../../color/colors.dart';

class ProfileController extends GetxController {
  var passwordVisible = false.obs;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
/*  Rx<File>? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path).obs;
      }
    } catch (e) {
      Utils.mySnackBar(msg: "Error picking image: $e");
    }
  }

  Future<void> _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        image = File(pickedFile.path).obs;
        update();
      }
    } catch (e) {
      Utils.mySnackBar(msg: "Error picking image: $e");
    }
  }

  Future<void> showPicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }*/

  ///on controller close
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  ///get user id from preferences
  String get userId => SharedPref.getUserId();

  /// network connectivity services

  /// api services and helper methods instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///api urls
  String get getProfile => apiServices.getProfile;
  String get updateProfile => apiServices.updateProfile;
  String get deleteUser => apiServices.deleteAccount;

  ///user profile data lists
  Rx<ProfileData?> profileData = null.obs;
  RxString profileImage = ''.obs;

  ///handle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }
  ///get profile
  Future<void> getUserProfile() async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getProfile), {'user_id': userId});
    ProfileModel profileModel = ProfileModel.fromJson(response);
    if (profileModel.data != null) {
      profileData = profileModel.data!.obs;
      profileImage.value = profileData.value?.image ?? '';
      nameController.text = profileData.value?.username ?? '';
      emailController.text = profileData.value?.email ?? '';
      phoneController.text = profileData.value?.mobile ?? '';
    } else {
      Utils.mySnackBar(
          title: 'Something went wrong',
          msg: 'please check your internet connection and try again');
    }
  }

  ///  api update profile
  updateProfileApi(File? image) async {
    isLoading.value = true;
    await ApiBaseHelper()
        .postMultipartAPICall(
            Uri.parse(updateProfile),
            {
              "user_id": userId,
              "mobile": phoneController.text,
              "username": nameController.text,
              "email": emailController.text,
            },
            fileKey: "image",
            files: image == null ? null : [image])
        .then((value) {
      log("value --> $value");
      isLoading.value = false;
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        Get.back(result: true);
      }
    }, onError: (error) {
      isLoading.value = false;
    });
  }

  ///  api request for delete user
  deleteAccount(String mobile, String password) async {
    isLoading.value = true;
    await ApiBaseHelper().postAPICall(Uri.parse(deleteUser), {
      "mobile":mobile,
      "password":password,
      'user_id': userId,
    }).then((value) {
      log("value --> $value");
      isLoading.value = false;
      if (value["error"] ?? true) {
        Utils.mySnackBar(
            title: "Error Found",
            msg: value["message"] ?? "Something went wrong please try again");
      } else {
        SharedPref.setLogOut();
        Get.to(() => const LoginScreen());
      }
    }, onError: (error) {
      isLoading.value = false;
    });
  }

  ///delete dialog
  Future<bool> showConfirmDialogDeletePopup(
      String title) async {
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();
    final passController = TextEditingController();
    bool? result = await Get.defaultDialog(
        title: title,
        content: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                fillColor: NatureColor.whiteTemp,
                controller: phoneController,
                hintText: "Enter Mobile No",
                maxLength: 10,
                textInputType: TextInputType.phone,
                validator: (val){
                  if(val == null || val.isEmpty){
                    return "required";
                  }
                  else if(val.length != 10){
                    return 'invalid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8,),
              Obx(() {
                return CustomTextFormField(
                  //isDense: false,
                  filled: true,
                  fillColor: NatureColor.whiteTemp,
                  hintText: "Enter password",
                  controller: passController,
                  // obscureText: true,
                  obscureText: !passwordVisible.value,
                  suffixIcon: passwordVisible.value
                      ? InkWell(
                      onTap: () {
                        togglePasswordVisibility();
                      },
                      child: const Icon(Icons.visibility))
                      : InkWell(
                      onTap: () {
                        togglePasswordVisibility();
                      },
                      child: const Icon(Icons.visibility_off)),

                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "required";
                    }
                    return null;
                  },
                );
              }
              ),
              const SizedBox(height: 8,),
              Obx(() {
                return !isLoading.value
                    ? CustomButton(
                    height: 40,
                    text: "Submit", onPressed: (){
                  if(formKey.currentState!.validate()) {
                    deleteAccount(phoneController.text, passController.text);
                  }
                }):const CircularProgressIndicator();
              }
              )
            ],
          ),
        ));
    if (result != null) {
      return result;
    }
    return false;
    // showDialog(
    //
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15),
    //       ),
    //       title: const Row(
    //         children: [
    //           SizedBox(width: 10),
    //           Text('Logout '),
    //         ],
    //       ),
    //       content: const Text('Do you want to logout?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             // Perform logout operation here
    //             Navigator.of(context).pop(); // Close the dialog
    //           },
    //           style: TextButton.styleFrom(
    //             foregroundColor: Colors.white,
    //             backgroundColor: Colors.red,
    //           ),
    //           child: const Text('No'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             SharedPref.setLogOut();
    //             Get.to(()=>const LoginScreen());
    //           },
    //           style: TextButton.styleFrom(
    //             foregroundColor: Colors.white,
    //             backgroundColor: NatureColor.primary,
    //           ),
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Future<void> refresh() async {
    await getUserProfile();
  }
}

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Profile Controller/Update Controller/profile_update_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  ProfileController profileUpdateController = Get.put(ProfileController());
  @override
  void initState() {
    profileUpdateController.refresh().then((val) {
      setState(() {});
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error!', msg: e.toString());
    });
    super.initState();
  }

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _imgFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _cropImage();
          image = File(pickedFile.path);
        });
      }
    } catch (e) {
      Utils.mySnackBar(msg: "Error picking image: $e");
    }
  }

  Future<void> _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _cropImage();
          image = File(pickedFile.path);
        });
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
  }
  CroppedFile? _croppedFile;
  Future<void> _cropImage() async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              //CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            //  CropAspectRatioPresetCustom(),
            ],
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: const CropperSize(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                NatureColor.scaffoldBackGround,
                NatureColor.scaffoldBackGround1,
                NatureColor.scaffoldBackGround1,
              ],
            ),
          ),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Edit Profile",
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
               /* Stack(
                  children: [
                    profileUpdateController.profileImage.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/nature_logo.png",
                              height: 100,
                              width: 100,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: NatureColor.whiteTemp,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image.file(
                                      image!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : profileUpdateController
                                        .profileImage.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.network(
                                          "${profileUpdateController.profileImage}",
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/images/nature_logo.png",
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                          ),
                    Positioned(
                      top: 85,
                      left: 75,
                      child: InkWell(
                        onTap: () {
                          showPicker(context);
                        },
                        child: Container(
                          width:
                              35, // Adjusted size for the camera icon container
                          height:
                              35, // Adjusted size for the camera icon container
                          decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            shape: BoxShape
                                .circle, // This makes the container circular
                            border: Border.all(color: NatureColor.whiteTemp),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: NatureColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),*/
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        profileUpdateController.profileImage.isEmpty
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/nature_logo.png",
                            height: 100,
                            width: 100,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                            color: NatureColor.whiteTemp,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.file(
                              image!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                              : profileUpdateController.profileImage.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              "${profileUpdateController.profileImage}",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/nature_logo.png",
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 85,
                          left: 75,
                          child: InkWell(
                            onTap: () {
                              showPicker(context);
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: NatureColor.whiteTemp,
                                shape: BoxShape.circle,
                                border: Border.all(color: NatureColor.whiteTemp),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: NatureColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add more widgets here if needed
                  ],
                ),
                const SizedBox(height: 20),
                listMenuView(),
                const SizedBox(height: 10),
              ],
            ),
          )),
        ),
      ),
    );
  }

  listMenuView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: "Full Name",
            fontSize: 4,
            color: NatureColor.allApp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: h * 0.01,
          ),
          CustomTextFormField(
            isDense: false,
            fillColor: NatureColor.whiteTemp,
            filled: true,
            hintText: "Enter your full name",
            controller: profileUpdateController.nameController,
            validator: (val) {
              if (val!.isEmpty) {
                return 'required';
              }
              return null;
            },
          ),
          SizedBox(
            height: h * 0.02,
          ),
          const CustomText(
            text: "Email Address",
            fontSize: 4,
            color: NatureColor.allApp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: h * 0.01,
          ),
          CustomTextFormField(
            isDense: false,
            fillColor: NatureColor.whiteTemp,
            filled: true,
            hintText: "Enter email",
            controller: profileUpdateController.emailController,
          ),
          SizedBox(
            height: h * 0.02,
          ),
          const CustomText(
            text: "Phone Number",
            fontSize: 4,
            color: NatureColor.allApp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: h * 0.01,
          ),
          CustomTextFormField(
            isDense: false,
            fillColor: NatureColor.whiteTemp,
            filled: true,
            readOnly: true,
            hintText: "Enter phone number",
            controller: profileUpdateController.phoneController,
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            height: h * 0.01,
          ),
          Center(
            child: Obx(() {
              return !profileUpdateController.isLoading.value
                  ? CustomButton(
                      height: 55,
                      text: "Save",
                      onPressed: () {
                        profileUpdateController.updateProfileApi(image);
                      },
                    )
                  : const CircularProgressIndicator();
            }),
          )
        ],
      ),
    );
  }
}

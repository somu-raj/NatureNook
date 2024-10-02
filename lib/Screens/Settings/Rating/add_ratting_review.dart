// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Rating%20Controller/rating_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customButton.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class AddRatingReviewScreen extends StatefulWidget {
  AddRatingReviewScreen(
      {super.key,
      this.productId,
      this.userRating,
      this.userReview,
      required this.userImages});
  String? productId, userRating, userReview;
  List<String> userImages;

  @override
  State<AddRatingReviewScreen> createState() => _AddRatingReviewScreenState();
}

class _AddRatingReviewScreenState extends State<AddRatingReviewScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  RatingController ratingController = Get.put(RatingController());

  @override
  void initState() {
    super.initState();
    ratingController.ratingTextController.text = widget.userReview.toString();
    ratingController.currentRating = double.parse(widget.userRating ?? "");
  }

  List<File> images = [];

  final ImagePicker _picker = ImagePicker();

  Future<void> _imgFromGallery() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          images =
              pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
        });
      }
    } catch (e) {
      Utils.mySnackBar(msg: "Error picking images: $e");
    }
  }

  Future<void> _imgFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path)); // Add the camera image to the list
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SafeArea(
              child: Column(
                children: [
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
                              text: "Add Your Review",
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "Your rating",
                          fontSize: 5,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: h * 0.045,
                          child: RatingBar.builder(
                            initialRating: ratingController.currentRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                ratingController.currentRating = rating;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const CustomText(
                          text: "Your review",
                          fontSize: 5,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: ratingController.ratingTextController,
                          decoration: const InputDecoration(
                            labelText: 'Enter your feedback',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: h * 0.080,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: NatureColor.primary, width: 2),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showPicker(context);
                                  },
                                  child: Container(
                                    height: h * 0.12,
                                    width: h * 0.14,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: NatureColor.textFormBackColors,
                                          width: 2),
                                    ),
                                    child: const Center(
                                      child: CustomText(
                                        text: "Choose Files",
                                        fontSize: 4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                    child: images.isEmpty &&
                                            widget.userImages.isEmpty
                                        ? const CustomText(
                                            text: "No files chosen",
                                            fontSize: 4,
                                            fontWeight: FontWeight.normal,
                                          )
                                        : const SizedBox.shrink()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (widget.userImages.isNotEmpty || images.isNotEmpty)
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              if (widget.userImages.isNotEmpty)
                                ...widget.userImages.map((image) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          image,
                                          height: w * 0.42,
                                          width: w * 0.42,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.userImages.remove(image);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              if (images.isNotEmpty)
                                ...images.map((image) {
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          image,
                                          height: w * 0.42,
                                          width: w * 0.42,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              images.remove(image);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })
                            ],
                          ),
                        const SizedBox(height: 16),
                        Center(
                          child: Obx(() {
                            return !ratingController.isLoading.value
                                ? CustomButton(
                                    text: "Submit",
                                    onPressed: () {
                                      if (ratingController.currentRating == 0) {
                                        Utils.mySnackBar(
                                            title: "Please add rating");
                                        return;
                                      } else {
                                        ratingController.addRatingApi(
                                            images,
                                            widget.productId.toString(),
                                            widget.userImages);
                                      }
                                    })
                                : const CircularProgressIndicator();
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

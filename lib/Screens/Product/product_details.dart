// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Product/product_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Custom%20Widgets/play_video_card.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Screens/Settings/Rating/rating_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late VideoPlayerController videoPlayerController;
  String videoUrl = '';
  ProductController productController = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  void initState() {
    productController.updateProductObserver(widget.product);
    productController.getAddressesList();
    videoUrl = productController.productObserver?.video ?? '';
    if (videoUrl.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl))..initialize();
    }
    if (productController.productList.isEmpty) {
      productController.getProductsList(
          'category_id', widget.product.categoryId ?? '');
    }
    super.initState();
  }

  reInitializePg() {
    if (videoUrl.isNotEmpty) {
      videoPlayerController.dispose();
    }
    videoUrl = productController.productObserver?.video ?? '';
    if (videoUrl.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl))..initialize();
    }
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    _pageController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int imagesLength =
        (productController.productObserver?.otherImages ?? []).length + 1;
    if ((productController.productObserver?.video ?? "").isNotEmpty) {
      imagesLength += 1;
    }
    return Scaffold(
      body: Container(
        height: h,
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
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * 0.42,
                    child: PageView.builder(
                        onPageChanged: (int page) {
                          productController.pageIndex.value = page;
                        },
                        controller: _pageController,
                        itemCount: imagesLength,
                        itemBuilder: (_, index) {
                          String imageUrl = '';
                          if (index == 0) {
                            if (videoUrl.isNotEmpty) {
                              videoPlayerController.pause();
                            }
                            imageUrl =
                                productController.productObserver?.image ?? '';
                          } else if (index !=
                              (productController.productObserver?.otherImages
                                          .length ??
                                      0) +
                                  1) {
                            if (videoUrl.isNotEmpty) {
                              videoPlayerController.pause();
                            }
                            imageUrl = productController
                                    .productObserver?.otherImages[index - 1] ??
                                '';
                          }
                          return Container(
                            height: h * 0.42,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8)),
                            child: index != imagesLength - 1 ||
                                    (productController.productObserver?.video ??
                                            '')
                                        .isEmpty
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child; // Image is fully loaded
                                      } else {
                                        return myObjectShimmer(
                                            height: h * 0.42, borderRadius: 12);
                                      }
                                    },
                                  )
                                : VideoCard(
                                    controller: videoPlayerController,
                                  ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          imagesLength,
                          (index) => Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                  color:
                                      index == productController.pageIndex.value
                                          ? NatureColor.primary
                                          : NatureColor.textFormBackColors,
                                  shape: BoxShape.circle,
                                ),
                              )),
                    );
                  })),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: productController.productObserver?.name ?? '',
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              productController.decrementProductCounter();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: NatureColor.primary,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Obx(() {
                            return Text(
                              '${productController.productCounter}',
                              // Display the current counter value
                              style: const TextStyle(fontSize: 16),
                            );
                          }),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              productController.incrementProductCounter();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: NatureColor.primary,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10), // Add some spacing
                        ],
                      ),
                    ],
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        CustomText(
                          text:
                              "₹${productController.productObserver?.variants[productController.variantIndex.value].specialPrice ?? ''}",
                          fontSize: 5,
                          fontWeight: FontWeight.bold,
                          color: NatureColor.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "₹${productController.productObserver?.variants[productController.variantIndex.value].price ?? ''}",
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  if (productController
                          .productObserver?.attributes.isNotEmpty ??
                      false)
                    Row(
                      children: [
                        CustomText(
                          text:
                              "${productController.productObserver?.attributes.first['name']} :  ",
                          fontSize: 4.2,
                          fontWeight: FontWeight.w500,
                        ),
                        if (productController.productObserver != null)
                          ...productController.productObserver!.variants
                              .map((variant) {
                            int index = productController
                                .productObserver!.variants
                                .indexOf(variant);
                            return InkWell(
                              onTap: () {
                                productController.variantIndex.value = index;
                              },
                              child: Obx(() {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  margin: const EdgeInsets.only(
                                    right: 6,
                                  ),
                                  decoration: BoxDecoration(
                                      color: productController
                                                  .variantIndex.value ==
                                              index
                                          ? NatureColor.primary1
                                          : null,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: productController
                                                      .variantIndex.value ==
                                                  index
                                              ? NatureColor.primary1
                                              : NatureColor
                                                  .textFormBackColors)),
                                  child: CustomText(
                                    text: variant.variantValues ?? '',
                                    fontSize: 4,
                                    color:
                                        productController.variantIndex.value ==
                                                index
                                            ? NatureColor.whiteTemp
                                            : NatureColor.allApp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }),
                            );
                          })
                      ],
                    ),
                  const Divider(
                    endIndent: 10,
                    indent: 2,
                    color: NatureColor.blackColor,
                    thickness: 2,
                  ),
                  const CustomText(
                    text: " Description",
                    fontSize: 5,
                    fontWeight: FontWeight.w600,
                    color: NatureColor.secondary,
                  ),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          CustomText(
                            text: productController
                                    .productObserver?.shortDescription ??
                                '',
                            fontSize: 4,
                            fontWeight: FontWeight.w400,
                            color: NatureColor.secondary,
                            maxLines: productController.showAllDescription.value
                                ? null
                                : 3,
                            overFlow: productController.showAllDescription.value
                                ? null
                                : TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  productController.showAllDescription.value =
                                      !productController
                                          .showAllDescription.value;
                                },
                                child: CustomText(
                                  text:
                                      productController.showAllDescription.value
                                          ? 'Show Less '
                                          : 'See All ',
                                  fontSize: 4.2,
                                  color: NatureColor.primary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                  const Divider(
                    endIndent: 10,
                    indent: 2,
                    color: NatureColor.blackColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      showProductSpecifications();
                    },
                    child: Container(
                        height: 50,
                        color: NatureColor.whiteTemp,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Specifications",
                                fontSize: 4,
                                fontWeight: FontWeight.w500,
                                color: NatureColor.secondary,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: NatureColor.colorOutlineBorder,
                              )
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if (productController.isLoading.value) return;
                      showPincodeEnterSheet();
                    },
                    child: Container(
                        height: 50,
                        color: NatureColor.whiteTemp,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return productController.isLoading.value
                                    ? Transform.scale(
                                        scale: 0.5,
                                        child:
                                            const CircularProgressIndicator(),
                                      )
                                    : CustomText(
                                        text:
                                            " ${productController.deliverable.value ? 'D' : "Not d"}eliverable at: ${productController.pinCodeController.text}",
                                        fontSize: 4,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            productController.deliverable.value
                                                ? NatureColor.primary2
                                                : Colors.red,
                                      );
                              }),
                              const CustomText(
                                  text: "Change",
                                  color: NatureColor.primary2,
                                  textDecoration: TextDecoration.underline,

                                  fontSize: 4.2)
                            ],
                          ),
                        )),
                  ),
                  productController.productObserver?.rating == "0.00"
                      ? const SizedBox.shrink()
                      : InkWell(
                          onTap: () {
                            Get.to(() => RatingScreen(
                                  productId:
                                      productController.productObserver?.id ??
                                          "",
                                ));
                          },
                          child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 10),
                              color: NatureColor.whiteTemp,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: "Customer Reviews/Ratings",
                                      fontSize: 4,
                                      fontWeight: FontWeight.w500,
                                      color: NatureColor.secondary,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: NatureColor.colorOutlineBorder,
                                    )
                                  ],
                                ),
                              )),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return productController.isLoading.value
                        ? const SizedBox.shrink()
                        /*: !productController.deliverable.value
                        ? const SizedBox.shrink()*/
                        : CustomButton(
                            text: "Add to Cart",
                            onPressed: () async {
                              Utils.showLoader();
                              await productController.addToCart();
                            });
                  }),
                  const SizedBox(height: 12),
                  Obx(() {
                    if (productController.productList.length == 1) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: "  More Products You may like -",
                          fontSize: 4.5,
                          fontWeight: FontWeight.bold,
                          color: NatureColor.secondary,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: large * 0.27,
                          child: productController.productList.isEmpty
                              ? myHorizontalShimmer(
                                  height: large * 0.26, width: large * 0.2)
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productController.productList.length,
                                  itemBuilder: (_, index) {
                                    Product productDetails =
                                        productController.productList[index];
                                    if (productController.productObserver?.id ==
                                        productDetails.id) {
                                      return const SizedBox.shrink();
                                    }
                                    return InkWell(
                                      onTap: () {
                                        productController.updateProductObserver(
                                            productDetails);
                                        reInitializePg();
                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: NatureColor.whiteTemp,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: large * 0.16,
                                              width: large * 0.19,
                                              decoration: BoxDecoration(
                                                  color: NatureColor.primary1
                                                      .withOpacity(0.4),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          productDetails
                                                                  .image ??
                                                              ''),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            CustomText(
                                              text: productDetails.name ?? '',
                                              fontSize: 4,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomText(
                                                  text:
                                                      "₹${productDetails.minMaxPrice?.specialPrice ?? ''}",
                                                  color: NatureColor.primary,
                                                  fontSize: 4.2,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                const Text(" - "),
                                                CustomText(
                                                  text:
                                                      "₹${productDetails.minMaxPrice?.maxPrice ?? ''}",
                                                  color: NatureColor.blackColor,
                                                  // textDecoration:
                                                  //     TextDecoration.lineThrough,
                                                  fontSize: 4.2,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 22,
                                                ),
                                                CustomText(
                                                  text: double.parse(
                                                          productDetails
                                                                  .rating ??
                                                              '')
                                                      .toStringAsFixed(1),
                                                  fontSize: 4,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showProductSpecifications({String? desc}) {
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: large * 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 20)
                .copyWith(top: 12, bottom: 20),
            decoration: const BoxDecoration(
                color: NatureColor.whiteTemp,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                          color: NatureColor.textFormBackColors,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  if ((productController.productObserver?.description ?? '')
                      .isNotEmpty)
                    Html(data: productController.productObserver?.description),
                  const Divider(
                    endIndent: 10,
                    indent: 2,
                    color: NatureColor.blackColor,
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
        isScrollControlled: true);
  }

  Future<void> showPincodeEnterSheet() async {
    String pincode = productController.pinCodeController.text;
    await Get.bottomSheet(
        Container(
          height: large * 0.3,
          padding: const EdgeInsets.symmetric(horizontal: 20)
              .copyWith(top: 12, bottom: 20),
          decoration: const BoxDecoration(
              color: NatureColor.whiteTemp,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                          color: NatureColor.textFormBackColors,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: productController.pincodeFormKey,
                    child: CustomTextFormField(
                      autoFocus: true,
                      maxLength: 6,
                      labelText: 'Enter Pincode',
                      textInputType: TextInputType.number,
                      controller: productController.pinCodeController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'enter pincode where to deliver';
                        } else if (val.removeAllWhitespace.length != 6 ||
                            !RegExp('^[1-9]{1}[0-9]{2}s{0,1}[0-9]{3}\$')
                                .hasMatch(val)) {
                          return 'invalid pin code';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                  text: "Check Availability",
                  onPressed: () {
                    if (productController.pincodeFormKey.currentState!
                        .validate()) {
                      Get.back();
                    }
                  })
              /*const Divider(
                endIndent: 10,
                indent: 2,
                color: NatureColor.blackColor,
                thickness: 2,
              ),*/
            ],
          ),
        ),
        isScrollControlled: true);
    if (productController.pinCodeController.text.length != 6) {
      productController.pinCodeController.text = pincode;
      productController.isLoading.value = false;
    } else {
      productController.checkIsDeliverable();
    }
  }
}

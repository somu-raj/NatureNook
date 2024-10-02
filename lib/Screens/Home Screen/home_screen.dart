// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Home Controller/home_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Custom Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Screens/Category/category_screen.dart';
import 'package:nature_nook_app/Screens/Product/product_details.dart';
import 'package:nature_nook_app/Screens/Product/products_list_screen.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/Screens/search_screen.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  void initState() {
    homeController.refresh();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await homeController.refresh();
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                NatureColor.scaffoldBackGround,
                NatureColor.scaffoldBackGround1,
                NatureColor.scaffoldBackGround1,
              ])),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  if (homeController.userId.isEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(() => const LoginScreen(
                                    canPop: true,
                                  ));
                            },
                            child: const CustomText(
                              text: "Login/Register      ",
                              fontSize: 4.8,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                    ).copyWith(top: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/nature_logo.png",
                          height: large * 0.05,
                        ),
                        SizedBox(
                          width: large * 0.02,
                        ),
                        Expanded(
                            child: SizedBox(
                          height: large * 0.065,
                          child: CustomTextFormField(
                            onTap: () {
                              Get.to(() => const SearchScreen());
                            },
                            hintText: "Search Products",
                            readOnly: true,
                            controller: homeController.searchProductController,
                            filled: true,
                            borderColor: NatureColor.primary2,
                            fillColor: NatureColor.whiteTemp,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: const Icon(Icons.mic),
                          ),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "Shop By Categories",
                              fontSize: 5.2,
                              fontWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => const CategoryScreen());
                              },
                              child: const CustomText(
                                text: "See All",
                                fontSize: 4.3,
                                color: NatureColor.primary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: large * 0.16,
                    child: Obx(() {
                      return homeController.catListData.isEmpty
                          ? myHorizontalShimmer(
                              height: large * 0.11, width: large * 0.11)
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.catListData.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    homeController.goToProductsList(
                                        homeController.catListData[index].id ??
                                            "");
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: large * 0.11,
                                        width: large * 0.11,
                                        clipBehavior: Clip.hardEdge,
                                        margin: EdgeInsets.only(
                                          right: 8.0,
                                          left: index == 0 ? 20 : 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: NatureColor.whiteTemp,
                                          border: const Border(
                                            bottom: BorderSide(
                                              color: NatureColor.primary1,
                                              width: 4,
                                            ),
                                            top: BorderSide(
                                              color: NatureColor.primary1,
                                              width: 1,
                                            ),
                                            left: BorderSide(
                                              color: NatureColor.primary1,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                              color: NatureColor.primary1,
                                              width: 1,
                                            ),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(homeController
                                                .catListData[index].image
                                                .toString()),
                                            scale: 1.2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CustomText(
                                        text:
                                            "${homeController.catListData[index].name}",
                                        fontSize: 4.4,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return CarouselSlider.builder(
                      itemCount: homeController.sliderData.isEmpty
                          ? 1
                          : homeController.sliderData.length,
                      itemBuilder: (_, index, index2) {
                        return Container(
                            height: large * 0.19,
                            width: double.infinity,
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: Constants.getDefaultBoxDecoration,
                            child: Obx(() {
                              if (homeController.sliderData.isEmpty) {
                                return Image.asset(
                                  'assets/images/nature_logo.png',
                                  height: large * 0.05,
                                  width: large * 0.05,
                                );
                              }
                              return InkWell(
                                onTap: () {
                                  if ((homeController.sliderData[index].type ??
                                              '')
                                          .toLowerCase() ==
                                      'products') {
                                    Get.to(() => ProductDetailsScreen(
                                          product: homeController
                                              .sliderData[index]
                                              .data
                                              .first as Product,
                                        ));
                                  } else if ((homeController
                                                  .sliderData[index].type ??
                                              '')
                                          .toLowerCase() ==
                                      'categories') {
                                    Get.to(() => ProductListScreen(
                                        kKey: 'category_id',
                                        id: homeController
                                                .sliderData[index].typeId ??
                                            ''));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    homeController.sliderData[index].image ??
                                        "",
                                    fit: BoxFit.fill,
                                    loadingBuilder: (_, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Image.asset(
                                          'assets/images/nature_logo.png',
                                          height: large * 0.05,
                                          width: large * 0.05,
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Center(
                                          child: Icon(Icons
                                              .error)); // Display an error icon if the image fails to load
                                    },
                                  ),
                                ),
                              );
                            }));
                      },
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          height: large * 0.2,
                          onPageChanged: (index, _) {
                            homeController.sliderIndex.value = index;
                          }),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          homeController.sliderData.length,
                          (index) => Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: index ==
                                              homeController.sliderIndex.value
                                          ? NatureColor.primary
                                          : NatureColor.textFormBackColors,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  )
                                ],
                              )),
                    );
                  })),
                  const SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return homeController.sections.isEmpty
                        ? SizedBox(
                            height: large * 0.28,
                            child: myHorizontalShimmer(
                                height: large * 0.26, width: large * 0.2),
                          )
                        : Column(
                            children: List.generate(
                                homeController.sections.length, (i) {
                              if (homeController.sections.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: homeController
                                                      .sections[i].title ??
                                                  '',
                                              fontSize: 5.2,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => ProductListScreen(
                                                      kKey: '',
                                                      id: '',
                                                      products: homeController
                                                          .sections[i]
                                                          .productDetails,
                                                    ));
                                              },
                                              child: const CustomText(
                                                text: "See All",
                                                fontSize: 4.3,
                                                color: NatureColor.primary,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SizedBox(
                                    height: large * 0.28,
                                    child: Obx(() {
                                      return homeController.sections[i]
                                              .productDetails.isEmpty
                                          ? myHorizontalShimmer(
                                              height: large * 0.16,
                                              width: large * 0.19)
                                          : ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  10 /*homeController
                                                  .sections[i]
                                                  .productDetails
                                                  .length*/
                                              ,
                                              itemBuilder: (_, index) {
                                                Product productDetail =
                                                    homeController.sections[i]
                                                        .productDetails[index];
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        ProductDetailsScreen(
                                                            product:
                                                                productDetail));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 4,
                                                        left: index == 0
                                                            ? 14
                                                            : 4),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          NatureColor.whiteTemp,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: large * 0.16,
                                                          width: large * 0.19,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: NatureColor
                                                                .primary1
                                                                .withOpacity(
                                                                    0.4),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  productDetail
                                                                          .image ??
                                                                      ''),
                                                              fit: BoxFit.fill,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        CustomText(
                                                          text: productDetail
                                                                  .name ??
                                                              '',
                                                          fontSize: 4,
                                                          overFlow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          width: large * 0.19,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomText(
                                                                text:
                                                                    "₹${productDetail.variants.first.specialPrice ?? ''}",
                                                                color: NatureColor
                                                                    .primary1,
                                                                fontSize: 4.2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .yellow,
                                                                    size: 22,
                                                                  ),
                                                                  CustomText(
                                                                    text: double.parse(
                                                                            productDetail.rating ??
                                                                                "")
                                                                        .toStringAsFixed(
                                                                            1),
                                                                    fontSize: 4,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        CustomText(
                                                          text:
                                                              "₹${productDetail.variants.first.price ?? ''}",
                                                          textDecoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontSize: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  )
                                ],
                              );
                            }),
                          );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Brands",
                              fontSize: 5.2,
                              fontWeight: FontWeight.w600,
                            ),
                            /* CustomText(
                              text: "See All",
                              fontSize: 4.3,
                              color: NatureColor.primary,
                            ),*/
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: large * 0.17,
                    child: Obx(() {
                      return homeController.allBrandsList.isEmpty
                          ? myHorizontalShimmer(
                              height: large * 0.11, width: large * 0.11)
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.allBrandsList.length,
                              itemBuilder: (_, index) {
                                return InkWell(
                                  onTap: () {
                                    homeController.goToSellerDetailScreen(
                                        homeController.allBrandsList[index]);
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: large * 0.13,
                                        width: large * 0.11,
                                        margin: EdgeInsets.only(
                                            right: 8.0,
                                            left: index == 0 ? 20 : 6),
                                        decoration: BoxDecoration(
                                            color: NatureColor.whiteTemp,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: const Border(
                                              bottom: BorderSide(
                                                  color: NatureColor.primary1,
                                                  width: 4),
                                              top: BorderSide(
                                                  color: NatureColor.primary1,
                                                  width: 1),
                                              left: BorderSide(
                                                  color: NatureColor.primary1,
                                                  width: 1),
                                              right: BorderSide(
                                                  color: NatureColor.primary1,
                                                  width: 1),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    homeController
                                                            .allBrandsList[
                                                                index]
                                                            .sellerProfile ??
                                                        ""),
                                                scale: 12)),
                                        // child: Image.asset("assets/brands/yash_organic.png"),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      CustomText(
                                        text: homeController
                                                .allBrandsList[index]
                                                .storeName ??
                                            '',
                                        fontSize: 3.5,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                );
                              });
                    }),
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

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart Controller/cart_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customAppBar.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Cart/cart_model.dart';
import 'package:nature_nook_app/Screens/Cart/empty_cart_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    cartController.pageLoading.value = true;
    cartController.refresh().then((value) {
      cartController.pageLoading.value = false;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await cartController.refresh().then((value) {
          setState(() {});
        });
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx(() {
            if (cartController.isSignIn.value &&
                (cartController.cartDataList.isNotEmpty ||
                    cartController.savedLaterDataList.isNotEmpty)) {
              return CustomAppBar(
                title: "Cart",
                refresh: true,
                onRefresh: () async {
                  Utils.showLoader();
                  cartController.cartDataList.value = [];
                  cartController.savedLaterDataList.value = [];
                  cartController.refresh().then((value) {
                    setState(() {});
                    Get.back();
                    if (value.error ?? true) {
                      Utils.mySnackBar(
                          title: "Error Found",
                          msg: value.message ??
                              'Something went wrong please try again');
                    }
                  }, onError: (e) {
                    Get.back();
                  });
                },
              );
            } else {
              return const SizedBox(
                height: 40,
              );
            }
          }),
        ),
        extendBodyBehindAppBar: true,
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
              child: cartController.pageLoading.value
                  ? myShimmer()
                  :
                      Obx(() {
                          return
                          cartController.emptyScreen.value
                            ?Center(
                              child: EmptyCartScreen(
                              signIn: cartController.isSignIn.value,
                            ))
                              : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5)
                                .copyWith(bottom: 40),
                            child: Column(
                              children: [
                                buildCartListView(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() {
                                      return cartController
                                          .cartDataList.isNotEmpty
                                          ? Container(
                                        height: 55,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 24),
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: NatureColor.whiteTemp,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            const CustomText(
                                                text: "Total Price",
                                                fontSize: 5),
                                            CustomText(
                                              text:
                                              "₹${cartController.subTotalPrice}",
                                              fontSize: 5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      )
                                          : const SizedBox.shrink();
                                    }),
                                    Obx(() {
                                      return cartController
                                          .savedLaterDataList.isNotEmpty
                                          ? Container(
                                        height: large * 0.04,
                                        margin: const EdgeInsets.only(
                                            bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: NatureColor.primary1
                                              .withOpacity(0.6),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                        ),
                                        child: const Row(
                                          children: [
                                            CustomText(
                                              text: "Saved For Later :",
                                              fontSize: 4.8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      )
                                          : const SizedBox.shrink();
                                    }),
                                    saveLaterListView(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                      )

            ),
          ),
        ),
        bottomSheet: Obx(() {
          return cartController.cartDataList.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  height: large * 0.06,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: "Checkout",
                    onPressed: () {
                      cartController.onCheckOut(cartController);
                    },
                  ),
                );
        }),
      ),
    );
  }

  Widget buildCartListView() {
    return Obx(() {
      return ListView.builder(
        itemCount: cartController.cartDataList.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (_, index) {
          CartData cartData = cartController.cartDataList[index];
          num productPrice = num.parse(cartData.productVariants.isNotEmpty? cartData.productVariants.first.specialPrice:cartData.specialPrice);
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: large * 0.12,
                    width: large * 0.14,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      image: DecorationImage(
                          image: NetworkImage(
                              cartData.productDetails.first.image ?? ''),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: cartData.productDetails.first.name ??
                                    '',
                                fontSize: 5,
                                fontWeight: FontWeight.bold,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: InkWell(
                                  onTap: () {
                                    cartController.removeProductFromCart(
                                        cartData.productVariantId ?? '','0');
                                  },
                                  child: const Icon(Icons.clear)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        cartData.productVariants.isEmpty?
                        Row(
                          children: [
                            CustomText(
                              text:
                              "₹${cartData.specialPrice}",
                              fontSize: 4,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text:
                              "₹${cartData.price}",
                              fontSize: 3.7,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ):
                        Row(
                          children: [
                            CustomText(
                              text:
                                  "₹${cartData.productVariants.first.specialPrice}",
                              fontSize: 4,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text:
                                  "₹${cartData.productVariants.first.price}",
                              fontSize: 3.7,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ),
                        if(cartData.productVariants.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Row(
                              children: [
                                CustomText(
                                  text: '${cartData.productVariants.first.attrName??''}:',
                                  fontSize: 3.5,
                                  color: NatureColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: cartData.productVariants.first.variantValues??'',
                                  fontSize: 4,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const CustomText(
                              text: "quantity:",
                              fontSize: 3.5,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            InkWell(onTap: (){
                              cartController.decrement(index,productPrice,cartData.productVariantId??'');
                            }, child: const Icon(Icons.remove,size: 20,)),
                            const SizedBox(width: 8),
                            Obx(() {
                                return CustomText(
                                  text: cartController.quantities[index].value.toString(),
                                  fontSize: 4,
                                  fontWeight: FontWeight.bold,
                                );
                              }
                            ),
                            const SizedBox(width: 8),
                            InkWell(onTap: (){
                              cartController.increment(index,productPrice,cartData.productVariantId??'');
                            }, child: const Icon(Icons.add,size: 20,))
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                cartController.saveForLater(
                                    cartData.productVariantId ?? '',
                                    cartController.quantities[index].value.toString(),
                                    "1");
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                      text: "Save For Later ",
                                      fontSize: 3.5),
                                  Icon(
                                    Icons.archive_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                        // Row(
                        //   children: [
                        //     const CustomText(
                        //       text: "sub total:",
                        //       fontSize: 3.5,
                        //       color: NatureColor.primary,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const SizedBox(width: 2),
                        //     CustomText(
                        //       text: '₹${cartData.subTotal??''}',
                        //       fontSize: 4,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget saveLaterListView() {
    return Obx(() {
      return ListView.builder(
        itemCount: cartController.savedLaterDataList.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (_, index) {
          CartData saveLaterData = cartController.savedLaterDataList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: large * 0.12,
                    width: large * 0.14,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      image: DecorationImage(
                          image: NetworkImage(
                              saveLaterData.productDetails.first.image ??
                                  ''),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: saveLaterData
                                        .productDetails.first.name ??
                                    '',
                                fontSize: 5,
                                fontWeight: FontWeight.bold,
                                overFlow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  await cartController.removeSaveForLater(
                                      saveLaterData.productVariantId ?? '',
                                      cartController.saveLaterQuantities[index].value.toString(),
                                      '0');
                                  // cartController.removeProductFromCart(
                                  //     saveLaterData.productVariantId ?? '','1');
                                },
                                child: const Icon(Icons.clear)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        saveLaterData.productVariants.isEmpty?
                        Row(
                          children: [
                            CustomText(
                              text:
                              "₹${saveLaterData.specialPrice}",
                              fontSize: 4,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text:
                              "₹${saveLaterData.price}",
                              fontSize: 3.7,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ):
                        Row(
                          children: [
                            CustomText(
                              text:
                              "₹${saveLaterData.productVariants.first.specialPrice}",
                              fontSize: 4,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text:
                              "₹${saveLaterData.productVariants.first.price}",
                              fontSize: 3.7,
                              textDecoration: TextDecoration.lineThrough,
                            ),
                          ],
                        ),
                        if(saveLaterData.productVariants.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                               CustomText(
                                text: '${saveLaterData.productVariants.first.attrName??''}:',
                                fontSize: 3.5,
                                color: NatureColor.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(width: 5),
                              CustomText(
                                  text: saveLaterData.productVariants.first.variantValues??'',
                                  fontSize: 4,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const CustomText(
                              text: "quantity:",
                              fontSize: 3.5,
                              color: NatureColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(width: 5),
                            InkWell(onTap: (){
                              cartController.decrementSaveLater(index,saveLaterData.productVariantId??'');
                            }, child: const Icon(Icons.remove,size: 20,)),
                            const SizedBox(width: 8),
                            Obx( () {
                                return CustomText(
                                  text: cartController.saveLaterQuantities[index].value.toString(),
                                  fontSize: 4,
                                  fontWeight: FontWeight.bold,
                                );
                              }
                            ),
                            const SizedBox(width: 8),
                            InkWell(onTap: (){
                              cartController.incrementSaveLater(index,saveLaterData.productVariantId??'');
                            }, child: const Icon(Icons.add,size: 20,)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                cartController.saveForLater(
                                    saveLaterData.productVariantId ?? '',
                                    cartController.saveLaterQuantities[index].value.toString(),
                                    '0');
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                      text: "Move to cart", fontSize: 3.5),
                                  Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                        // Row(
                        //   children: [
                        //     const CustomText(
                        //       text: "sub total:",
                        //       fontSize: 3.5,
                        //       color: NatureColor.primary,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     const SizedBox(width: 2),
                        //     CustomText(
                        //       text: '₹${cartData.subTotal??''}',
                        //       fontSize: 4,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

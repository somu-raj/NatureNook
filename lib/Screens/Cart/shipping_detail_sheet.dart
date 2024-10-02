// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Cart Controller/cart_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Cart/cart_model.dart';
import 'package:nature_nook_app/Screens/Cart/place_order_screen.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ShippingDetailSheet extends StatefulWidget {
  const ShippingDetailSheet({super.key, required this.cartController});

  final CartController cartController;

  @override
  State<ShippingDetailSheet> createState() => _ShippingDetailSheetState();
}

class _ShippingDetailSheetState extends State<ShippingDetailSheet> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.83,
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .copyWith(top: 12, bottom: 20),
      decoration: const BoxDecoration(
        color: NatureColor.whiteTemp,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: RawScrollbar(
        controller: _scrollController,
        thickness: 6,
        thumbColor: NatureColor.primary,
        thumbVisibility: true,
        shape: const StadiumBorder(),
        trackColor: NatureColor.textFormBackColors,
        trackRadius: const Radius.circular(8),
        trackVisibility: true,
        minThumbLength: 16,
        timeToFade: const Duration(seconds: 2),
        padding: const EdgeInsets.only(right: -12, top: 10),
        // scrollbarOrientation: ScrollbarOrientation.left,
        child: SingleChildScrollView(
          controller: _scrollController,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            Container(
              decoration: Constants.getDefaultBoxDecoration,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/shipping icons/location_icon.png",
                            height: h * 0.04,
                            width: h * 0.04,
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.0),
                            child: CustomText(
                              text: "Shipping Details",
                              fontSize: 4.4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      InkWell(onTap: () {
                        widget.cartController
                            .onChangeShippingAddress(widget.cartController);
                      }, child: Obx(() {
                        return CustomText(
                          text: widget.cartController.userAddress.value.isEmpty
                              ? 'Add Address'
                              : "Change",
                          fontSize: 4.2,
                          color: NatureColor.primary2,
                          fontWeight: FontWeight.w500,
                        );
                      })),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: h * 0.05,
                      ),
                      Expanded(child: Obx(() {
                        if (widget.cartController.userAddress.value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return CustomText(
                          text: widget.cartController.userAddress.value,
                          fontSize: 4.2,
                          color: NatureColor.textFormBackColors,
                        );
                      })),
                    ],
                  ),
                ],
              ),
            ),
            /*const SizedBox(height: 10,),
                Container(
                  decoration: Constants.getDefaultBoxDecoration,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/shipping icons/credit_card_icon.png",height: h*0.04,width: h*0.04,),
                          const Padding(
                            padding:  EdgeInsetsDirectional.only(start: 10.0),
                            child:  CustomText(text: "Shipping Details", fontSize: 4.4,fontWeight: FontWeight.bold,),),
                        ],
                      ),
                    ],
                  ),
                ),*/
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cartController.cartDataList.length,
                itemBuilder: (_, index) {
                  CartData cartData = widget.cartController.cartDataList[index];
                  ProductDetail productDetail = cartData.productDetails.first;
                  bool deliverable =
                      widget.cartController.checkIsDeliverablePincode(index);
                  return Container(
                    decoration: Constants.getDefaultBoxDecoration,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      productDetail.image ?? '',
                                      height: h * 0.08,
                                      width: h * 0.08,
                                      fit: BoxFit.fill,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 10.0),
                                      child: CustomText(
                                        text: productDetail.name ?? '',
                                        fontSize: 4.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    cartData.productVariants.isEmpty
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(start: 10.0),
                                                child: CustomText(
                                                  text:
                                                      "₹${cartData.specialPrice}",
                                                  fontSize: 4,
                                                  color: NatureColor.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text: "₹${cartData.price}",
                                                fontSize: 3.7,
                                                textDecoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .only(start: 10.0),
                                                child: CustomText(
                                                  text:
                                                      "₹${cartData.productVariants.first.specialPrice}",
                                                  fontSize: 4,
                                                  color: NatureColor.primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text:
                                                    "₹${cartData.productVariants.first.price}",
                                                fontSize: 3.7,
                                                textDecoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ],
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: NatureColor.allApp,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "quantity",
                                  fontSize: 4.2,
                                  color: NatureColor.textFormBackColors,
                                ),
                                CustomText(
                                  text:
                                      // "${widget.cartController.cartDataList[index].qty}",
                                      "${widget.cartController.quantities[index]}",
                                  fontSize: 4.2,
                                  color: NatureColor.textFormBackColors,
                                ),
                              ],
                            ),
                            if (cartData.productVariants.isNotEmpty)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: cartData
                                            .productVariants.first.attrName ??
                                        '',
                                    fontSize: 4.2,
                                    color: NatureColor.textFormBackColors,
                                  ),
                                  CustomText(
                                    text: cartData.productVariants.first
                                            .variantValues ??
                                        '',
                                    fontSize: 4.2,
                                    color: NatureColor.textFormBackColors,
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                  text: "Tax",
                                  fontSize: 4.2,
                                  color: NatureColor.textFormBackColors,
                                ),
                                CustomText(
                                  text:
                                      "${widget.cartController.cartDataList[index].taxPercentage}%",
                                  fontSize: 4.2,
                                  color: NatureColor.textFormBackColors,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    text: "Sub Total",
                                    fontSize: 4.2,
                                    color: NatureColor.textFormBackColors),
                                CustomText(
                                    text:
                                        "₹${widget.cartController.cartDataList[index].subTotal}",
                                    fontSize: 4.2,
                                    color: NatureColor.textFormBackColors),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text:
                                        "${deliverable ? 'Deliverable' : 'Not Deliverable'} at ${widget.cartController.selectedAddressData?.pincode ?? ""}",
                                    fontSize: 4.4,
                                    color: deliverable
                                        ? NatureColor.primary2
                                        : Colors.red),
                              ],
                            ),
                            if (!deliverable)
                              const CustomText(
                                  text:
                                      "Please change address or save this product for later",
                                  fontSize: 4.2,
                                  color: NatureColor.textFormBackColors),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            Container(
                decoration: Constants.getDefaultBoxDecoration,
                padding: const EdgeInsets.all(12),
                child: Obx(() {
                  final promo = widget.cartController.selectedPromoData.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: promo.promoCode == null
                                ? 'Promo Code'
                                : promo.promoCode ?? '',
                            fontSize: 4.4,
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {
                              widget.cartController.applyPromoCode();
                            },
                            child: CustomText(
                                text: promo.promoCode == null
                                    ? "Apply"
                                    : 'Change',
                                fontSize: 4.2,
                                color: NatureColor.primary),
                          ),
                        ],
                      ),
                      if (promo.promoCode != null)
                        widget.cartController.promoInvalidMessage == null
                            ? CustomText(
                                text: widget.cartController
                                    .getPromoCodeAppliedText(),
                                fontSize: 3.5,
                                color: NatureColor.primary1,
                              )
                            : CustomText(
                                text:
                                    widget.cartController.promoInvalidMessage ??
                                        '',
                                fontSize: 3.5,
                                color: Colors.red,
                              )
                    ],
                  );
                })),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: Constants.getDefaultBoxDecoration,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: NatureColor.primary.withOpacity(0.1)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: const Icon(
                                  Icons.history,
                                  color: NatureColor.primary,
                                )),
                          ),
                          const Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.only(start: 10.0),
                                child: CustomText(
                                  text: "Order Summary",
                                  fontSize: 4.4,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: NatureColor.allApp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Total quantity",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                          CustomText(
                            // text: widget
                            //         .cartController.cartModel?.totalQuantity ??
                            //     '',
                            text: widget.cartController.quantities.fold<num>(0,
                                (p, e) {
                              return p + e.value;
                            }).toString(),
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Delivery Charge",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                          CustomText(
                            text:
                                "+${widget.cartController.cartModel?.deliveryCharge ?? ''}",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Sub Total",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                          CustomText(
                            text:
                                // "₹${widget.cartController.cartModel?.subTotal ?? ''}",
                                "+${widget.cartController.subTotalPrice.value}",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                          ),
                        ],
                      ),
                      Obx(() {
                        if (widget.cartController.selectedPromoData.value
                                    .promoCode ==
                                null ||
                            widget.cartController.promoInvalidMessage != null ||
                            widget.cartController.discount == 0) {
                          return const SizedBox.shrink();
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomText(
                              text: "Discount",
                              fontSize: 4.2,
                              color: NatureColor.allApp,
                            ),
                            CustomText(
                              text: "-${widget.cartController.discount ?? ''}",
                              fontSize: 4.2,
                              color: NatureColor.allApp,
                            ),
                          ],
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Total Payable",
                            fontSize: 4.2,
                            color: NatureColor.allApp,
                            fontWeight: FontWeight.bold,
                          ),
                          Obx(() {
                            return CustomText(
                              text:
                                  // "₹${widget.cartController.cartModel?.overallAmount ?? ''}",
                                  "₹${widget.cartController.totalPrice.value}",
                              // "₹${widget.cartController.totalPrice + num.parse(widget.cartController.cartModel?.deliveryCharge ?? '0')}",
                              fontSize: 4.2,
                              color: NatureColor.allApp,
                              fontWeight: FontWeight.bold,
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                text: "Continue",
                onPressed: () {
                  if (widget.cartController.userAddress.value.isEmpty) {
                    Utils.mySnackBar(
                        title: "Add Address",
                        msg: 'Please add address to continue');
                    return;
                  } else if (widget.cartController.deliverableList
                      .contains(false)) {
                    Utils.mySnackBar(
                        title: "Not Deliverable",
                        msg: 'Please change address to continue');
                    return;
                  }
                  Get.to(() => PlaceOrderScreen(
                        cartController: widget.cartController,
                      ));
                })
          ]),
        ),
      ),
    );
  }
}

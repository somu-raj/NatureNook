// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Profile%20Controller/address_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customAppBar.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Address%20Model/address_model.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ManageAddressScreen extends StatefulWidget {
  final String addressId;
  const ManageAddressScreen({super.key, this.addressId = ''});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  AddressController addressController = Get.put(AddressController());

  double h = Constants.largeSize;
  double w = Constants.screen.width;
  int currentIndex = 0;

  @override
  void initState() {
    if (widget.addressId.isNotEmpty) {
      addressController.changeAddress = true;
      if (widget.addressId == 'add') {
        Future.delayed(Duration.zero, () {
          addressController.goToAddAddressScreen(addressController);
        });
        return;
      }
    }
    addressController.pageLoading.value = true;
    addressController.refresh().then((value) {
      addressController.pageLoading.value = false;
      if (addressController.addressesData.isEmpty) {
        Future.delayed(Duration.zero, () {
          addressController.goToAddAddressScreen(addressController);
        });
      }
    }, onError: (e) {
      Utils.mySnackBar(
          title: 'Error Found',
          msg: e.toString(),
          duration: const Duration(seconds: 2));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomSimpleAppBar(title: 'Shipping Address'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addressController.goToAddAddressScreen(addressController);
        },
        backgroundColor: NatureColor.primary,
        shape: RoundedRectangleBorder(
          // Ensures circular shape
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.add,
          color: NatureColor.whiteTemp,
        ),
      ),
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
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await addressController.refresh();
            },
            child: buildListView(),
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return Obx(() {
      return addressController.pageLoading.value
          ? myShimmer(height: 100)
          : addressController.addressesData.isEmpty
              ? const Center(
                  child: CustomText(
                    text: 'No Address Found\nPlease add address',
                    fontSize: 6,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    children: List.generate(
                        addressController.addressesData.length, (index) {
                      AddressData addressData =
                          addressController.addressesData[index];
                      return InkWell(
                        onTap: () {
                          if (widget.addressId.isEmpty) return;
                          Get.back(result: addressData);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: NatureColor.whiteTemp,
                              boxShadow: widget.addressId == addressData.id
                                  ? const [
                                      BoxShadow(
                                          color: NatureColor.primary2,
                                          blurRadius: 3,
                                          spreadRadius: 2)
                                    ]
                                  : null,
                              border: Border.all(
                                  width: 2,
                                  color: widget.addressId == addressData.id
                                      ? NatureColor.primary2
                                      : NatureColor.textFormBackColors
                                          .withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text:
                                          '${addressData.name}, ${addressData.mobile}',
                                      fontSize: 5.0,
                                      color: NatureColor.allApp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          addressController.goToUpdateAddress(
                                              addressData, addressController);
                                        },
                                        child: const CustomText(
                                          text: "Edit",
                                          fontSize: 4.5,
                                          color: NatureColor.primary,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                CustomText(
                                  text: addressController
                                      .getUserAddress(addressData),
                                  fontSize: 3.5,
                                  color: NatureColor.textFormBackColors,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: addressData.isDefault == '1',
                                          onChanged: (bool? value) {
                                            addressController.markDefault(
                                                addressData.id ?? '');
                                          },
                                          activeColor: NatureColor
                                              .primary, // Red color for the checkbox
                                        ),
                                        CustomText(
                                          text:
                                              "${addressData.isDefault == '1' ? 'Marked' : 'Mark'} as Default",
                                          fontSize: 4,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          bool shouldDelete =
                                              await Utils.showConfirmDialog(
                                                  "Delete",
                                                  "You want to delete this address?");
                                          if (!shouldDelete) return;

                                          addressController.deleteAddress(
                                              addressData.id ?? '');
                                        },
                                        icon: Icon(Icons.delete_forever_sharp,
                                            color: Colors.redAccent
                                                .withOpacity(0.5)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
    });
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Profile%20Controller/address_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customButton.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen(
      {super.key, required this.addressController, required this.update});
  final AddressController addressController;
  final bool update;
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  final pinFocusNode = FocusNode();
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
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: SafeArea(
                child: Form(
                  key: widget.addressController.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  text: "Address",
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: ' Address type:',
                              fontSize: 4.5,
                              fontWeight: FontWeight.bold,
                            ),
                            Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                          value: "Home",
                                          groupValue: widget.addressController
                                              .addressType.value,
                                          onChanged: (val) {
                                            widget.addressController.addressType
                                                .value = val.toString();
                                          }),
                                      // const SizedBox(width: 4,)
                                      const CustomText(
                                          text: 'Home', fontSize: 4.2)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 'Work',
                                          groupValue: widget.addressController
                                              .addressType.value,
                                          onChanged: (val) {
                                            widget.addressController.addressType
                                                .value = val.toString();
                                          }),
                                      // const SizedBox(width: 4,)
                                      const CustomText(
                                          text: 'Work', fontSize: 4.2)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: "Other",
                                          groupValue: widget.addressController
                                              .addressType.value,
                                          onChanged: (val) {
                                            widget.addressController.addressType
                                                .value = val.toString();
                                          }),
                                      // const SizedBox(width: 4,)
                                      const CustomText(
                                          text: 'Other', fontSize: 4.2)
                                    ],
                                  ),
                                  const SizedBox()
                                ],
                              );
                            }),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Name",
                              controller:
                                  widget.addressController.nameController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Mobile Number",
                              maxLength: 10,
                              textInputType: TextInputType.phone,
                              controller:
                                  widget.addressController.phoneController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Alternate Mobile Number",
                              maxLength: 10,
                              textInputType: TextInputType.phone,
                              controller: widget
                                  .addressController.alternatePhoneController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Flat/House no., Building Name ",
                              controller:
                                  widget.addressController.addressController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Landmark, Ex:Near Apollo Tower",
                              controller:
                                  widget.addressController.landmarkController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Enter Area",
                              controller:
                                  widget.addressController.areaController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Pin code",
                              maxLength: 6,
                              focusNode: pinFocusNode,
                              textInputType: TextInputType.number,
                              onChanged: (val) {
                                if (val.length == 6) {
                                  pinFocusNode.unfocus();
                                  widget.addressController
                                      .getPostOfficesData(val)
                                      .then((value) {
                                    if (!value) {
                                      pinFocusNode.requestFocus();
                                    }
                                  });
                                }
                              },
                              controller:
                                  widget.addressController.pinCodeController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'required';
                                } else if (val.length != 6) {
                                  return 'invalid Pin Code';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Enter City",
                              controller:
                                  widget.addressController.cityController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "State",
                              controller:
                                  widget.addressController.stateController,
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
                            CustomTextFormField(
                              isDense: false,
                              fillColor: NatureColor.whiteTemp,
                              filled: true,
                              hintText: "Country",
                              controller:
                                  widget.addressController.countryController,
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
                            CustomButton(
                                text: "Save",
                                onPressed: () {
                                  if (widget.update) {
                                    widget.addressController.updateAddress();
                                  } else {
                                    widget.addressController.addNewAddress();
                                  }
                                })
                          ],
                        ),
                      )
                      // const SizedBox(height: 20,),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

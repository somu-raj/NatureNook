
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nature_nook_app/Custom%20Widgets/customButton.dart';
import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Cart/cart_model.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({super.key, required this.promoCodes, required this.promoCode});
  final List<PromoData> promoCodes;
  final String promoCode;
  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  // final TextEditingController _promoCodeController = TextEditingController();
  // String? _promoStatus;
  // bool _isPromoApplied = false;
  
  //list of colors for different promo codes
  List<Color> colors = [
    Colors.cyan,
    Colors.redAccent,
    Colors.teal,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.indigoAccent,
  ];
  

  // void _applyPromoCode([String? selectedCode]) {
  //   setState(() {
  //     // Use selectedCode if passed, otherwise use the input from the text field
  //     final promoCode = selectedCode ?? _promoCodeController.text;
  //
  //     if (promoCode == 'SAVE10' || promoCode == 'WELCOME20' || promoCode == 'FREESHIP' || promoCode == 'HOLIDAY15') {
  //       _isPromoApplied = true;
  //       _promoStatus = 'Promo code "$promoCode" applied successfully!';
  //     } else if (promoCode.isEmpty) {
  //       _isPromoApplied = false;
  //       _promoStatus = 'Please enter or select a promo code.';
  //     } else {
  //       _isPromoApplied = false;
  //       _promoStatus = 'Invalid promo code. Please try again.';
  //     }
  //   });
  // }

  /*// const CustomText(
              //   text:'Enter your promo code:',
              //   fontSize: 5,
              //   fontWeight: FontWeight.bold,
              // ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: _promoCodeController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Promo Code',
              //   ),
              // ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _applyPromoCode,
              //   child: Text('Apply Promo Code'),
              // ),
              // SizedBox(height: 20),
              // if (_promoStatus != null)
              //   const CustomText(
              //     text:'Select your promo code:',
              //     fontSize: 4.5,
              //     fontWeight: FontWeight.bold,
              //     color: _isPromoApplied ? Colors.green : Colors.red,,
              //   ),
              //   Text(
              //     _promoStatus!,
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: _isPromoApplied ? Colors.green : Colors.red,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // Divider(height: 30, thickness: 2),
              // Text(
              //   'Available Promo Codes:',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(height: 10),
              // List of colorful promo codes*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Promo Code'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: Constants.screen.height,
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
          child:
          widget.promoCodes.isEmpty?
              const Center(child: CustomText(
                  text: "No Promo Codes Available",
                  fontSize: 4.5,
                fontWeight: FontWeight.bold,
              ),):
          ListView.builder(
            itemCount: widget.promoCodes.length,
            itemBuilder: (context, index) {
              // final int randomColorIndex = Random.secure().nextInt(colors.length);
              final PromoData promoData = widget.promoCodes[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors[index%colors.length],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    promoData.image ?? '',
                                    height: Constants.screen.height * 0.06,
                                    width: Constants.screen.height * 0.06,
                                    fit: BoxFit.fill,
                                  )),
                              const SizedBox(width: 8,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                     text:  promoData.promoCode??'',
                                      fontSize: 4.8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 2),
                                    // RichText(
                                    //     text: TextSpan(
                                    //       text: "fjgjfg fhe dfhertu eturturtu cghrtu dturturt dtuterywtwyu hfyer",
                                    //       children: [
                                    //         TextSpan(
                                    //           text: ' see more',
                                    //           style: TextStyle(
                                    //             color: Colors.blue.shade900
                                    //           )
                                    //         )
                                    //       ]
                                    //     )
                                    // )
                                    CustomText(
                                      text: promoData.message??'',
                                      fontSize: 4.2,
                                      color: Colors.white70,
                                      overFlow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    if((promoData.message??'').length > 40)
                                    InkWell(onTap:(){
                                      showDialog(context:context,
                                        builder: (_){
                                          return Dialog(
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(16),
                                                  margin: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: CustomText(
                                                    text: promoData.message??'',
                                                    fontSize: 4.2,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 12,top: 8),
                                                  child: InkWell(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(Icons.close),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    },child: CustomText(text: "See All", fontSize: 4.3, color: Colors.blue.shade900,)),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.promoCode == promoData.promoCode?
                        CustomButton(
                            width: 64,
                            height: 28,
                            fontSize: 0.8,
                            color: Colors.red.shade700,
                            text: 'Remove', onPressed: (){
                          Get.back(result: PromoData());
                        }):
                        CustomButton(
                           width: 64,
                            height: 28,
                            fontSize: 0.8,
                            text: 'Apply', onPressed: (){
                          Get.back(result: promoData);
                        })
                        /*const Icon(
                          Icons.local_offer,
                          color: Colors.white,
                        )*/,
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Expire on ${promoData.endDate}',
                          fontSize: 4,
                          color: Colors.white70,
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
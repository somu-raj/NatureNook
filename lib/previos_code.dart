/// product controller -31/08
/*import 'package:get/get.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Product/product_controller.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:nature_nook_app/Screens/auth/login_screen.dart';
import 'package:nature_nook_app/Utils/shared_preferences.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import '/Users/Sanjay/Custom Widgets/customButton.dart';
import '/Users/Sanjay/Custom Widgets/customText.dart';
import '/Users/Sanjay/Downloads/Api Services/api_helper_methods.dart';
import '/Users/Sanjay/Downloads/Api Services/api_services.dart';
import '/Users/Sanjay/Downloads/Network Connectivity/connectivty_check.dart';
import '/Users/Sanjay/color/colors.dart';
import '/Users/Sanjay/constants/constants.dart';

class ProductController extends GetxController {


  ///api services instance
  ApiServices apiServices = ApiServices();
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  ///get api urls
  String get getProductsUrl => apiServices.getProducts;
  String get addToCartUrl => apiServices.addToCart;

  ///declare variables
  RxBool isLoading = false.obs;
  RxList<Product> productList = <Product>[].obs;
  RxList<RxInt> counters = List<RxInt>.filled(1, 0.obs).obs;
  RxInt productCounter = 1.obs;
  RxList<RxBool> isFavoritedList = List<RxBool>.filled(1, false.obs).obs;
  RxBool pageLoading = false.obs;

  ///get products list category wise
  getProductsList(String catId) async {
    dynamic response = await apiBaseHelper
        .postAPICall(Uri.parse(getProductsUrl), {"category_id": catId});
    productList.value = ProductsModel.fromJson(response).data;
    counters.value = List<RxInt>.filled(productList.length, 0.obs);
    isFavoritedList.value = List<RxBool>.filled(productList.length, false.obs);
  }

  ///update the product quantity
  void updateProductQuantity(index) {
    if (counters[index] > 1) {
      productCounter = counters[index];
    } else {
      productCounter.value = 1;
    }
  }

  ///increment count of product quantity
  void incrementCounter(int index) {
    counters[index].value++;
  }

  void incrementProductCounter() {
    productCounter.value++;
  }

  ///decrement count of product quantity
  void decrementCounter(int index) {
    if (counters[index].value > 0) {
      counters[index].value--;
    }
  }

  void decrementProductCounter() {
    if (productCounter.value > 1) {
      productCounter.value--;
    }
  }

  /// toggle add to wishlist functionality
  void toggleFavorite(int index) {
    isFavoritedList[index].value = !isFavoritedList[index].value;
  }

  ///add to cart method
  Future<void> addToCart(String productVariantId) async {
    bool isLoggedIn = SharedPref.getLogin();
    String userId = SharedPref.getUserId();
    if(!isLoggedIn || userId.isEmpty){
      Utils.mySnackBar(title: 'Login', msg: 'Please sign in to continue');
      Get.to(()=>const LoginScreen(canPop: true,));
      return;
    }
    if (productCounter.value < 1 || productVariantId.isEmpty) {
      Utils.mySnackBar(title: 'Add Quantity', msg: 'Please add minimum 1 quantity');
      return;
    }
    isLoading.value = true;
    Map<String, dynamic> param = {
      'user_id': userId,
      'product_variant_id': productVariantId,
      /*'is_saved_for_later': 1,*/
      'qty': productCounter.value.toString()
    };
     await apiBaseHelper
        .postAPICall(Uri.parse(addToCartUrl), param)
        .then(
            (value) {
              if(value['error']??true){
                Utils.mySnackBar(title: "Error Found",msg: value['message']??'Something went wrong!,\nPlease try again later');
              }
              else{
                Utils.mySnackBar(title: "Product Added to Cart",msg: '...going to cart',);
                Get.to(()=>DashboardScreen(selectedIndex: 2));
              }
            },
        onError: (e) {
          Utils.mySnackBar(title: "Error Found!!",msg: e.toString());
        });
    isLoading.value = false;
  }

  @override
  Future<void> refresh({String catId = ""}) async {
    await getProductsList(catId);
  }
}*/

/// product detail screen -02/09
/*import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  const  ProductDetailsScreen({super.key,required this.product,});
  final Product product;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductController productController = Get.put(ProductController());

  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  void initState() {
    productController.updateProductObserver(widget.product);
    if(productController.productList.isEmpty){
      productController.getProductsList('category_id', widget.product.categoryId??'');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Container(
                            height: h*0.42,
                            decoration : BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(productController.productObserver.value?.image ??
                                        ''),
                                    fit: BoxFit.fill
                                )
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: productController
                                  .productObserver.value?.name ??
                                  '',
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
                                    '${productController.productCounter}', // Display the current counter value
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
                        Row(
                          children: [
                            Obx(() {
                              return CustomText(
                                text:
                                "₹${productController.productObserver.value?.minMaxPrice?.specialPrice ?? ''}",
                                fontSize: 5,
                                fontWeight: FontWeight.bold,
                                color: NatureColor.primary,
                              );
                            }),
                            const SizedBox(
                              width: 5,
                            ),
                            Obx(() {
                              return Text(
                                "₹${productController.productObserver.value?.minMaxPrice?.maxPrice ?? ''}",
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
                  const SizedBox(
                    height: 4,
                  ),
                  Obx(() {
                    return  SizedBox(
                      height: h*0.09,
                      child: ListView(
                        children: [
                          CustomText(
                            text: productController
                                .productObserver.value?.shortDescription ??
                                '',
                            fontSize: 4,
                            fontWeight: FontWeight.w400,
                            color: NatureColor.secondary,
                          ),
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
                  Container(
                      height: 50,
                      color: NatureColor.whiteTemp,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Deliver to : 452010",
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
                  const SizedBox(height: 12),

                  Obx(() {
                    if(productController.productList.length == 1){
                      return const SizedBox.shrink();
                    }
                      return Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          const CustomText(
                            text: "  More Products-",
                            fontSize: 4.5,
                            fontWeight: FontWeight.bold,
                            color: NatureColor.secondary,
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: large * 0.28,
                            child:
                            productController.productList.isEmpty?
                                myHorizontalShimmer(height: large*0.26,width: large*0.15):
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: productController.productList.length,
                                itemBuilder: (_, index) {
                                  Product productDetails = productController.productList[index];
                                  if(productController.productObserver.value?.id == productDetails.id){
                                    return const SizedBox.shrink();
                                  }
                                  return InkWell(
                                    onTap: (){
                                      productController.updateProductObserver(productDetails);
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.symmetric(horizontal: 4),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: NatureColor.whiteTemp,
                                          borderRadius: BorderRadius.circular(12)),
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
                                                image:  DecorationImage(
                                                  image: NetworkImage(
                                                      productDetails.image??''),
                                                  fit: BoxFit.fill
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          CustomText(
                                            text: productDetails.name??'',
                                            fontSize: 4,
                                            fontWeight: FontWeight.bold,
                                          ),
                                           Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: "₹${productDetails.minMaxPrice?.specialPrice??''}",
                                                color: NatureColor.primary,
                                                fontSize: 4.2,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(
                                                width: 50,
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
                                                    text: productDetails.rating??'4',
                                                    fontSize: 4,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                           CustomText(
                                            text: "₹${productDetails.minMaxPrice?.specialPrice??''}",
                                            color: NatureColor.blackColor,
                                            textDecoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 4.2,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),

                        ],
                      );
                    }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return productController.isLoading.value
                        ? const SizedBox.shrink()
                        : CustomButton(
                        text: "Add to Cart",
                        onPressed: () async {
                          Utils.showLoader();
                          await productController.addToCart(
                              productController.productObserver.value
                                  ?.variants.first.id  ??
                                  '');
                        });
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
                  Obx(() {
                    if ((productController.productObserver.value?.description ??
                        '')
                        .isNotEmpty) {
                      return Html(
                          data: productController
                              .productObserver.value?.description);
                    }
                    return const SizedBox.shrink();
                  }),
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
}
*/

/// speech code
/*final SpeechToText speech = SpeechToText();
  List<LocaleName> _localeNames = [];
  String _currentLocaleId = '';
  String speechStatus = '';
  bool _hasSpeech = false;
  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: false,
        finalTimeout: const Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();
       log("locale names --> $_localeNames");
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale?.localeId ?? '';
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    if (hasSpeech) showSpeechDialog();
  }

  void errorListener(SpeechRecognitionError error) {
      Utils.mySnackBar(title: 'Speech Error!', msg: error.errorMsg);
  }

  void statusListener(String status) {
      speechStatus = status;
  }

  Future<dynamic> startListening() async {
    dynamic listenResult = await speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
        ));
    return listenResult;
  }


  double minSoundLevel = 0;
  double maxSoundLevel = 1;
  double level = 0.5;
  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
      this.level = level;
  }

  void stopListening() {
    speech.stop();
    level = 0.0;
  }

  void cancelListening() {
    speech.cancel();
      level = 0.0;
  }

  String speechResult = '';
  void resultListener(SpeechRecognitionResult result) {
      speechResult = result.recognizedWords;
      natureSearchController.queryText.value = speechResult;
    if (result.finalResult) {
      Future.delayed(const Duration(seconds: 1)).then((_) async {
        natureSearchController.searchTextController.clear();
        natureSearchController.searchTextController.text = speechResult;
        natureSearchController.searchTextController.selection = TextSelection.fromPosition(
            TextPosition(offset: natureSearchController.searchTextController.text.length));
      });
    }
  }

  showSpeechDialog() {
    return Get.dialog( StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return AlertDialog(
            backgroundColor: NatureColor.whiteTemp.withOpacity(0.6),
            title: const Center(child:  CustomText(text: "Search", fontSize: 4.8)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius:.26,
                          spreadRadius: level * 1.5,
                          color: NatureColor.primary2)
                    ],
                    color: NatureColor.whiteTemp,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                      icon: const Icon(
                        Icons.mic,
                        color: NatureColor.primary,
                      ),
                      onPressed: () {
                        if (!_hasSpeech) {
                          initSpeechState();
                        } else {
                          speech.isListening
                              ? null
                              : startListening().then((value){
                          });
                        }
                        setStater((){});
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(speechResult),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  color: NatureColor.whiteTemp.withOpacity(0.3),
                  child: Center(
                    child: speech.isListening
                        ? const Text(
                      "I'm listening...",
                      style: TextStyle(
                          color: NatureColor.blackColor,
                          fontWeight: FontWeight.bold),
                    )
                        : const Text(
                      'Not listening',
                      style: TextStyle(
                          color: NatureColor.blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
*/

///ios notification permission
/*
//For iOS, make sure to request notification permissions and handle background modes
//in Xcode. Add this code in your AppDelegate.swift:
import UIKit
import Firebase
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
*/
/*Ensure that you have the necessary permissions for iOS by adding the following to Info.plist:

xml
Copy code
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
<key>FirebaseAppDelegateProxyEnabled</key>
<false/>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide better service.</string>*/
///android
/*<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<receiver
    android:name="com.dexterous.flutterlocalnotifications.receivers.ActionReceiver"
    android:exported="true"/>

<service android:name="com.google.firebase.messaging.FirebaseMessagingService"
    android:exported="true">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>
*/

///stack page
/*
                                InkWell(
                                  onTap: () {
                                     // _pageController.jumpToPage(productController.pageIndex.value - 1);
                                  },
                                  child: Obx( () {
                                      return
                                      productController.pageIndex.value != 0?
                                        Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            color: NatureColor.whiteTemp.withOpacity(0.7),
                                            shape: BoxShape.circle
                                          ),
                                          child: const Center(child: Icon(Icons.chevron_left)),
                                        ),
                                        ),
                                      ):
                                      const SizedBox();
                                    }
                                  ),
                                ),
                                  InkWell(
                                    onTap: (){
                                      //  _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
                                    },
                                    child: Obx( () {
                                      return
                                        productController.pageIndex.value  != (productController.productObserver?.otherImages.length??0)+1?
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(
                                              height: 36,
                                              width: 36,
                                              decoration: BoxDecoration(
                                                  color: NatureColor.whiteTemp.withOpacity(0.7),
                                                  shape: BoxShape.circle
                                              ),
                                              child: const Center(child: Icon(Icons.chevron_right)),
                                            ),
                                          ),
                                        ):
                                        const SizedBox();
                                    }),
                                  ),*/

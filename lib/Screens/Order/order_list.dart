// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Order%20Controller/order_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/My%20Order/get_order_model.dart';
import 'package:nature_nook_app/Screens/Order/order_details.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

import '../Notification/get_notification_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    orderController.pageLoading.value = true;
    orderController.refresh().then((val) {
      orderController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await orderController.getOrderModel();
      },
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
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
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
                                  text: "My Orders",
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => const NotificationScreen());
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  color: NatureColor.primary,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2), // Adjust padding
                        child:
                            buildListView(), // Call your ListView builder here
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  List<OrderModel> searchList = [];
  bool isLoadingmore = true;

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Obx(() {
        return orderController.pageLoading.value
            ? Center(child: myShimmer(height: 100))
            : orderController.orderList.isEmpty
                ? const Center(
                    child: CustomText(text: "No order found...", fontSize: 5))
                : ListView.builder(
                    itemCount: orderController.orderList.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (_, index) {
                      /* OrderItem? orderItem;
              try {
                if (orderController.orderList[index].orderItems.isNotEmpty) {
                  orderItem = orderController.orderList[index].orderItems[index];
                }
                if (isLoadingmore && index == (orderController.orderList[index].orderItems.length - 1)) {
                  orderController.getOrderModel();
                }
              } on Exception catch (_) {

              }*/
                      final dateAdded =
                          orderController.orderList[index].dateAdded;
                      final String formattedDate =
                          DateFormat('yyyy-MM-dd').format(dateAdded!);
                      final String formattedTime =
                          DateFormat('HH:mm:ss').format(dateAdded);

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderDetailsScreen(
                                        orderModelList:
                                            orderController.orderList[index])));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: h * 0.12,
                                    width: h * 0.14,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.4),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${orderController.orderList[index].orderItems.first.image}"),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*  const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.arrow_forward_ios_rounded,color: NatureColor.primary,)
                                ],
                              ),*/
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                        text:
                                            "${orderController.orderList[index].name}",
                                        fontSize: 5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomText(
                                            text: "Order Placed on",
                                            fontSize: 3.2,
                                            color:
                                                NatureColor.textFormBackColors,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          const SizedBox(width: 5),
                                          Row(
                                            children: [
                                              CustomText(
                                                text:
                                                    formattedDate, // Date part
                                                fontSize: 3.2,
                                                color: NatureColor
                                                    .textFormBackColors,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              const SizedBox(width: 5),
                                              const CustomText(
                                                text: "at",
                                                fontSize: 3.2,
                                                color: NatureColor
                                                    .textFormBackColors,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              const SizedBox(width: 5),
                                              CustomText(
                                                text:
                                                    formattedTime, // Time part
                                                fontSize: 3.2,
                                                color: NatureColor
                                                    .textFormBackColors,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: NatureColor.primary,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }
}

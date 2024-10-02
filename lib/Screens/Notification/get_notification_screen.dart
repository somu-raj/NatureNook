// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Notification Controller/notification_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  double h = Constants.largeSize;
  double w = Constants.screen.width;
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    notificationController.pageLoading.value = true;
    notificationController.refresh().then((val) {
      notificationController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await notificationController.getNotification();
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
                                  text: "My Notifications",
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
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

  Widget buildListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Obx(() {
        return notificationController.pageLoading.value
            ? Center(child: myShimmer(height: 100))
            : notificationController.notificationData.isEmpty
                ? const Center(
                    child: CustomText(text: "No order found...", fontSize: 5))
                : ListView.builder(
                    itemCount: notificationController.notificationData.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (_, index) {
                      final dateAdded = notificationController
                          .notificationData[index].dateSent;
                      final String formattedDate =
                          DateFormat('dd-MMM-yyyy').format(dateAdded!);

                      final String formattedTime =
                          DateFormat('hh:mm a').format(dateAdded);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 10.0),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Optional Icon for notification type
                                const Icon(
                                  Icons.notifications,
                                  size: 28,
                                  color: NatureColor.primary,
                                ),
                                const SizedBox(width: 12),
                                // Notification content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Notification message
                                      Text(
                                        "${notificationController.notificationData[index].title}",
                                        style: const TextStyle(
                                          fontSize: 16, // Increased font size
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .black87, // Text color for better readability
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${notificationController.notificationData[index].message}",
                                        style: const TextStyle(
                                          fontSize: 16, // Increased font size
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .black87, // Text color for better readability
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Notification date and time
                                      Text(
                                        'Date: $formattedDate',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        'Time: $formattedTime',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
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

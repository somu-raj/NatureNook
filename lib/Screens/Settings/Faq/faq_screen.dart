// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Setting%20Controller/faqs_controller.dart';
import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  FaqsController faqsController = Get.put(FaqsController());
  @override
  void initState() {
    faqsController.pageLoading.value = true;
    faqsController.refresh().then((val) {
      faqsController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

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
                                text: "FAQs",
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
                    faqListView(),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  bool isExpanded = false;
  Widget faqListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Obx(() {
        return faqsController.pageLoading.value
            ? Center(child: myShimmer(height: 60))
            : faqsController.faqListData.isEmpty
                ? const Center(child: Text("No faqs found.."))
                : ListView.builder(
                    itemCount: faqsController.faqListData.length ?? 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(isExpanded ? 10 : 10),
                        ),
                        color: NatureColor.whiteTemp,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  '${faqsController.faqListData[index].question}'),
                            ),
                            tilePadding: EdgeInsets.zero,
                            iconColor: NatureColor.primary,
                            collapsedIconColor: NatureColor.secondary,
                            backgroundColor: Colors.grey[200],
                            children: [
                              ListTile(
                                title: Text(
                                    '${faqsController.faqListData[index].answer}'),
                              ),
                            ],
                            onExpansionChanged: (bool expanded) {
                              setState(() {
                                isExpanded = expanded;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }
}

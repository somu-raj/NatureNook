// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Category Controller/category_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom%20Widgets/customAppBar.dart';
import 'package:nature_nook_app/Custom%20Widgets/myShimmer.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    categoryController.pageLoading.value = true;
    categoryController.refresh().then((val) {
      categoryController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

  double h = Constants.largeSize;
  double w = Constants.screen.width;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await categoryController.refresh();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(title: "Categories"),
        body: Container(
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Obx(() {
                    return categoryController.pageLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: myShimmerGrid(ratio: 0.9),
                          )
                        : categoryController.catListData.isEmpty
                            ? const Center(child: Text("No category found.."))
                            : GridView.builder(
                                itemCount:
                                    categoryController.catListData.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 1.0,
                                  crossAxisSpacing: 1.0,
                                  childAspectRatio: 0.9,
                                ),
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          categoryController.goToProductsList(
                                              categoryController
                                                      .catListData[index].id ??
                                                  '');
                                        },
                                        child: Container(
                                          height: h * 0.19,
                                          width: h * 0.19,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: NatureColor.whiteTemp,
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
                                                      categoryController
                                                              .catListData[
                                                                  index]
                                                              .image ??
                                                          ''),
                                                  scale: 0.8)),
                                        ),
                                      ),
                                      CustomText(
                                          text: categoryController
                                                  .catListData[index].name ??
                                              '',
                                          fontSize:
                                              5.0), // Adjusted font size for visibility
                                    ],
                                  );
                                },
                              );
                  }),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

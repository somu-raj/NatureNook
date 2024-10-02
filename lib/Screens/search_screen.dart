// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Search%20Controller/search_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customTextFormField.dart';
import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
import 'package:nature_nook_app/Screens/Product/products_list_screen.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  NatureSearchController natureSearchController =
      Get.put(NatureSearchController());

  //FocusNode focusNode = FocusNode();
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;

  @override
  void initState() {
    natureSearchController.getTagsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: large * 0.09,
          backgroundColor: Colors.transparent,
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
          title: Builder(builder: (BuildContext context) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: SizedBox(
                  height: large * 0.065,
                  width: w,
                  child: CustomTextFormField(
                    onChanged: (val) {
                      natureSearchController.queryText.value =
                          val.toLowerCase();
                    },
                    hintText: "Search Products",
                    // focusNode: focusNode,
                    controller: natureSearchController.searchTextController,
                    filled: true,
                    borderColor: NatureColor.primary2,
                    fillColor: NatureColor.whiteTemp,
                    autoFocus: true,
                    prefixIcon: InkWell(
                        onTap: () {
                          // Get.back();
                        },
                        child: const Icon(
                          Icons.search,
                          size: 25,
                        )),
                    suffixIcon: InkWell(onTap: () {
                      if (natureSearchController.queryText.isEmpty) {
                        if (!natureSearchController.hasSpeech.value) {
                          natureSearchController.initSpeechState();
                        } else {
                          natureSearchController.showSpeechDialog();
                        }
                      } else {
                        natureSearchController.queryText.value = '';
                        natureSearchController.searchTextController.clear();
                      }
                    }, child: Obx(() {
                      return natureSearchController.queryText.isEmpty
                          ? const Icon(
                              Icons.mic,
                              size: 25,
                            )
                          : const Icon(
                              Icons.close,
                              size: 25,
                            );
                    })),
                  ),
                ),
              ),
            );
          }),
          titleSpacing: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: h,
          width: w,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                NatureColor.scaffoldBackGround,
                NatureColor.scaffoldBackGround1,
                NatureColor.scaffoldBackGround1,
              ])),
          child: Obx(() {
            return natureSearchController.queryText.isNotEmpty
                ? buildSuggestions(context)
                : const SizedBox();
          }),
        ));
  }

  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = natureSearchController
            .queryText.value.isEmpty
        ? <String>[]
        : natureSearchController.tags
            .where(
                (tag) => tag.startsWith(natureSearchController.queryText.value))
            .toList();
    return natureSearchController.queryText.isNotEmpty && suggestionList.isEmpty
        ? const SafeArea(
            child: Center(
                child: CustomText(text: "Product not found", fontSize: 4.5)))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Get.to(() => ProductListScreen(
                      id: suggestionList[index], kKey: "search"));
                  Get.delete<NatureSearchController>();
                },
                leading: const Icon(Icons.search),
                title: RichText(
                  text: TextSpan(
                    text: suggestionList[index].substring(
                        0, natureSearchController.queryText.value.length),
                    style: const TextStyle(
                        color: NatureColor.primary,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: suggestionList[index].substring(
                            natureSearchController.queryText.value.length),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

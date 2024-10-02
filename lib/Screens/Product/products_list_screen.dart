// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:nature_nook_app/Controllers/Product/product_controller.dart';
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/Custom Widgets/myShimmer.dart';
import 'package:nature_nook_app/Custom%20Widgets/customAppBar.dart';
import 'package:nature_nook_app/Models/Dashboard%20Models/Product/products_model.dart';
import 'package:nature_nook_app/Screens/Product/product_details.dart';
import 'package:nature_nook_app/Utils/utils.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class ProductListScreen extends StatefulWidget {
  final String kKey;
  final String id;
  final bool onlyProducts;
  final List<Product>? products;
  const ProductListScreen(
      {super.key,
      required this.id,
      this.onlyProducts = false,
      required this.kKey,
      this.products});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductController productController = Get.put(ProductController());
  double large = Constants.largeSize;
  double h = Constants.screen.height;
  double w = Constants.screen.width;
  int currentIndex = 0;
  bool isGridView = true;

  @override
  void initState() {
    if (widget.products != null) {
      productController.productList.value = widget.products!;
      productController.getCountersNFavoriteList();
      return;
    }
    productController.pageLoading.value = true;
    productController.refresh(key: widget.kKey, id: widget.id).then((val) {
      productController.pageLoading.value = false;
    }, onError: (e) {
      Utils.mySnackBar(title: 'Error Found!', msg: e.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProductController>();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (widget.products == null) {
          await productController.refresh();
        }
      },
      child: !widget.onlyProducts
          ? Scaffold(
              appBar: const CustomSimpleAppBar(title: 'Product List'),
              extendBodyBehindAppBar: true,
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
                    child: Column(
                      children: [
                        /*SizedBox(
                        height: large * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                   Get.back();
                                  },
                                  child:
                                      const Icon(Icons.arrow_back_rounded)),
                            ),
                            const CustomText(
                              text: "Product List",
                              fontSize: 5,
                              fontWeight: FontWeight.bold,
                            ),
                            const Row(
                              children: [
                               */
                        /* Icon(Icons.favorite_border),
                                SizedBox(width: 4),*/
                        /*
                                Icon(Icons.notifications_none_outlined),
                                SizedBox(width: 12),
                                // Padding(
                                //   padding: EdgeInsets.only(right: 10),
                                //   child: Icon(Icons.search),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),*/
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        buildGridView(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                buildGridView(),
              ],
            ),
    );
  }

  Widget productsView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          color: NatureColor.whiteTemp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.filter_list_sharp),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Filter by",
                style: TextStyle(
                  color: NatureColor.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Image.asset(
                "assets/icons/up-and-down-arrows.png",
                height: 15,
                width: 15,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Sort by",
                style: TextStyle(
                  color: NatureColor.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(isGridView
                    ? Icons.format_list_bulleted_outlined
                    : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    isGridView = !isGridView; // Toggle the view
                  });
                },
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        isGridView ? buildGridView() : buildListView(),
      ],
    );
  }

  Widget buildGridView() {
    double childAspectRatio = (w / h) * 1.55;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() {
        /*if(productController.productList.isEmpty){
             return const Center(child: CustomText(text: "No Products Found!!", fontSize: 5),);
           }*/
        return productController.pageLoading.value
            ? myShimmerGrid(ratio: 0.73)
            : productController.productList.isEmpty
                ? const Center(child: Text("No product found.."))
                : GridView.builder(
                    itemCount: productController.productList.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (_, index) {
                      Product product = productController.productList[index];
                      return InkWell(
                        onTap: () {
                          productController.updateProductQuantity(index);
                          Get.to(() => ProductDetailsScreen(product: product));
                          Get.delete<ProductController>();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  height: large * 0.16,
                                  width: large * 0.19,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.4),
                                    image: DecorationImage(
                                      image: NetworkImage(product.image ?? ""),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text: product.name ?? "loading...",
                                fontSize: 4,
                                fontWeight: FontWeight.bold,
                                overFlow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text:
                                        "₹${product.variants.first.specialPrice ?? ""}",
                                    fontSize: 4,
                                    color: NatureColor.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.yellow, size: 22),
                                      Text(double.parse(product.rating ?? "")
                                          .toStringAsFixed(1)),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "₹${product.variants.first.price ?? ""}",
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      }),
    );
  }

  Widget buildListView() {
    return Obx(() {
      if (productController.productList.isEmpty) {
        return const Center(
          child: CustomText(text: "No Products Found!!", fontSize: 5),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
          itemCount: productController.productList.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (_, index) {
            Product product = productController.productList[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {
                  productController.updateProductQuantity(index);
                  Get.to(() => ProductDetailsScreen(
                        product: product,
                      ));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: large * 0.12,
                        width: large * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          image: DecorationImage(
                              image: NetworkImage(product.image ?? ""),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: product.name ?? "loading...",
                                    fontSize: 5,
                                    fontWeight: FontWeight.bold,
                                    overFlow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.yellow, size: 22),
                                    Text(double.parse(product.rating ?? "")
                                        .toStringAsFixed(1)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text:
                                          "₹${product.variants.first.specialPrice ?? ""}",
                                      fontSize: 4,
                                      color: NatureColor.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "₹${product.variants.first.price ?? ""}",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                /* Obx((){
                                  return GestureDetector(
                                    onTap: () {
                                      productController.toggleFavorite(index);
                                    },
                                    child: Icon(
                                      productController.isFavoritedList[index].value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: productController.isFavoritedList[index].value
                                          ? Colors.red
                                          : Colors.grey, // Change color when filled
                                      size: 20,
                                    ),
                                  );
                                })*/
                              ],
                            ),
                            const SizedBox(height: 5),
                            /*      Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        productController
                                            .decrementCounter(index);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: NatureColor.blackColor
                                                .withOpacity(0.4),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
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
                                        '${productController.counters[index].value}', // Display the current counter value
                                        style: const TextStyle(fontSize: 16),
                                      );
                                    }),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        productController
                                            .incrementCounter(index);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: NatureColor.primary
                                                .withOpacity(0.4),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 10), // Add some spacing
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        productController
                                                .isFavoritedList[index].value
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: productController
                                                .isFavoritedList[index].value
                                            ? Colors.red
                                            : Colors
                                                .grey, // Change color when filled
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        productController.toggleFavorite(index);
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.shopping_cart_sharp,
                                        size: 20),
                                    const SizedBox(width: 4),
                                  ],
                                ),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

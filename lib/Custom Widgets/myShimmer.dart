// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:nature_nook_app/color/colors.dart';

Widget myShimmer({double height = 80}) {
  return SafeArea(
    child: Shimmer.fromColors(
      baseColor: NatureColor.primary.withOpacity(0.4),
      highlightColor: NatureColor.primary.withOpacity(0.2),
      enabled: true,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              height: height,
              decoration: BoxDecoration(
                  color: NatureColor.primary,
                  borderRadius: BorderRadius.circular(30)),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget myHorizontalShimmer({double height = 80, double width = 150}) {
  return Shimmer.fromColors(
    baseColor: NatureColor.primary.withOpacity(0.4),
    highlightColor: NatureColor.primary.withOpacity(0.2),
    enabled: true,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        width: width,
        margin: const EdgeInsets.only(right: 10),
        height: height,
        decoration: BoxDecoration(
          color: NatureColor.primary,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}

Widget myShimmerGrid({double ratio = 1}) {
  return SafeArea(
    child: Shimmer.fromColors(
      baseColor: NatureColor.primary.withOpacity(0.4),
      highlightColor: NatureColor.primary.withOpacity(0.2),
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: ratio,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: NatureColor.primary,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    ),
  );
}

Widget myObjectShimmer(
    {double height = 80,
    double width = double.infinity,
    double borderRadius = 30}) {
  return Shimmer.fromColors(
    baseColor: NatureColor.primary.withOpacity(0.4),
    highlightColor: NatureColor.primary.withOpacity(0.2),
    enabled: true,
    child: Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: NatureColor.primary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}

Widget myObjectShimmerFullScreen(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  return Shimmer.fromColors(
    baseColor: NatureColor.primary.withOpacity(0.4),
    highlightColor: NatureColor.primary.withOpacity(0.2),
    enabled: true,
    child: Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        color: NatureColor.primary,
        borderRadius: BorderRadius.circular(
            10), // पूरी स्क्रीन के लिए कोई borderRadius नहीं
      ),
    ),
  );
}

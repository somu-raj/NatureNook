// import 'package:flutter/material.dart';
// import 'package:nature_nook_app/Custom%20Widgets/customText.dart';
//
// class ExpandableText extends StatefulWidget {
//   final String text;
//   final int maxLines;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Color color;
//   final bool isExpanded;
//
//   const ExpandableText({
//     super.key,
//     required this.text,
//     this.maxLines = 4,
//     required this.fontSize,
//     required this.fontWeight,
//     required this.color, required this.isExpanded,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//             text: text,
//             fontSize: fontSize,
//             fontWeight: fontWeight,
//           color: color,
//          overFlow:isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
//          maxLines: isExpanded ? null : maxLines,
//         ),
//         InkWell(
//           onTap: () {
//               isExpanded = !isExpanded;
//
//           },
//           child: Text(
//             isExpanded ? 'Show Less' : 'See All',
//             style: TextStyle(color: Colors.blue),
//           ),
//         ),
//       ],
//     );
//   }
// }

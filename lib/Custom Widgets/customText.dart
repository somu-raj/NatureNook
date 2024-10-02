// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/constants/constants.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final int? maxLines;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overFlow;
  final FontStyle fontStyle;
  final String? fontFamily;
  final TextAlign textAlign;
  final double? letterSpacing;
  final TextDecoration? textDecoration;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.fontStyle = FontStyle.normal,
    this.fontFamily,
    this.overFlow,
    this.textAlign = TextAlign.start,
    this.letterSpacing,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Constants.getResponsiveFontSize(fontSize),
        color: color,
        decoration: textDecoration,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
      ),
      maxLines: maxLines,
      overflow: overFlow,
      textAlign: textAlign,
    );
  }
}

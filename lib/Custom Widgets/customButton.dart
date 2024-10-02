// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final String? fontFamily;
  final double? fontSize;
  final double? letterSpacing;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = NatureColor.primary2,
    this.textColor = NatureColor.whiteTemp,
    this.height,
    this.width,
    this.borderRadius = 24.0,
    this.fontFamily,
    this.fontSize,
    this.letterSpacing,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Responsive(
        child: Container(
          padding: height == null
              ? const EdgeInsets.symmetric(vertical: 10, horizontal: 24)
              : null,
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
              child: CustomText(
            text: text,
            fontSize: Constants.getResponsiveFontSize(fontSize ?? 1.4),
            color: textColor,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
          )),
        ),
      ),
    );
  }
}

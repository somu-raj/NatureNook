// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/Custom Widgets/customText.dart';
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/constants.dart';

class CustomListContainer extends StatelessWidget {
  const CustomListContainer(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.onTap});
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.largeSize * 0.064,
      decoration: BoxDecoration(
          color: NatureColor.whiteTemp,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: NatureColor.textFormBackColors)),
      child: ListTile(
        dense: true,
        onTap: onTap,
        hoverColor: NatureColor.primary1,
        leading: Image.asset(
          iconPath,
          width: Constants.largeSize * 0.03,
          height: Constants.largeSize * 0.03,
        ),
        title: CustomText(
          text: text,
          fontSize: 5,
          fontWeight: FontWeight.w500,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: NatureColor.primary,
          size: Constants.largeSize * 0.025,
        ),
      ),
    );
  }
}

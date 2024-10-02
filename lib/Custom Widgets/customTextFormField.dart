// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:nature_nook_app/color/colors.dart';
import 'package:nature_nook_app/constants/responsive.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? filled;
  final bool? isDense;
  final Color? fillColor;
  final Color? borderColor;
  final bool? obscureText;
  final bool? readOnly;
  final bool? autoFocus;
  final int? maxLength;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    this.hintText,
    required this.controller,
    this.focusNode,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.borderColor,
    this.validator,
    this.prefixIcon,
    this.filled,
    this.fillColor,
    this.isDense,
    this.textInputType,
    this.onTap,
    this.maxLength,
    this.readOnly,
    this.autoFocus,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText!,
        keyboardType: textInputType,
        onTap: onTap,
        maxLength: maxLength,
        readOnly: readOnly ?? false,
        autofocus: autoFocus ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          counterText: "",
          filled: filled,
          isDense: isDense ?? true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor ??
                  NatureColor.textFormBackColors.withOpacity(
                      0.5), // Set the color when the field is selected
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: borderColor ??
                  NatureColor.textFormBackColors
                      .withOpacity(0.5), // Set the default border color
            ),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 12,
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red, // Set the default border color
            ),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

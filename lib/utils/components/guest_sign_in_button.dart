import 'package:flutter/material.dart';

class GuestSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final double fontSize;

  const GuestSignInButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 12,
    this.borderColor,
    this.textColor,
    this.height = 50,
    this.fontSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? Colors.grey[400]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          'Continue with Guest',
          style: TextStyle(
            fontSize: fontSize,
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}


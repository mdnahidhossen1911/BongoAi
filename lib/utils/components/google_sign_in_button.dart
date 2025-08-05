import 'package:flutter/material.dart';

import '../../utils/assets_path.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onPressed,
        child: Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.tealAccent.shade400,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsPath.googleLogo, height: 24, width: 24),
              const SizedBox(width: 12),
              Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

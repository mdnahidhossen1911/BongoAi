import 'package:flutter/material.dart';

import '../../utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry? margin;

  const AppLogo({super.key, this.height = 36, this.width = 36, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Image.asset(
        AssetsPath.appLogo,
        height: height,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_app/themes/app_assets.dart';

import '../themes/app_color.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final Gradient gradient;
  final Color primary;
  final double borderRadius;
  final Widget? icon;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.white,
    this.width = double.infinity,
    this.height = 44.0,
    this.gradient = Gradients.defaultGradientButton,
    this.primary = Colors.transparent,
    this.borderRadius = 100,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox() : icon ?? const SizedBox(),
        style: ElevatedButton.styleFrom(
          // foregroundColor: AppColors.white,
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

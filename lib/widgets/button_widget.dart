import 'package:flutter/material.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final Gradient gradient;
  final Color primary;
  final BorderRadiusGeometry? borderRadius;
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
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(100),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox() : icon ?? const SizedBox(),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(100),
          ),
        ),
        label: Text(
          text,
          style: AppTextStyles.h5.copyWith(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

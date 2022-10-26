import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final Gradient gradient;
  final Color primary;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.white,
    this.width = double.infinity,
    this.height = 44.0,
    this.gradient = Gradients.defaultGradientButton,
    this.primary = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: primary,
          onPrimary: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_app/themes/app_color.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String nameImage;
  final Color colorImage;
  final double? width;
  final double? height;

  const MyIconButton({
    Key? key,
    required this.onTap,
    required this.nameImage,
    this.colorImage = AppColors.white,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Image.asset(
        nameImage,
        color: colorImage,
        width: width,
        height: height,
      ),
    );
  }
}

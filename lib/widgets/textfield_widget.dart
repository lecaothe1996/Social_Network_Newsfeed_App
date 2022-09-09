import 'package:flutter/material.dart';

import '../themes/app_color.dart';

class MyTextField extends StatelessWidget {
  final String hintText;

  const MyTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        style: const TextStyle(fontSize: 17, color: AppColors.white),
        obscureText: hintText == 'Password' ? true : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 17, color: AppColors.white),
          border: InputBorder.none,
          prefix: const Padding(padding: EdgeInsets.only(left: 20)),
          suffix: const Padding(padding: EdgeInsets.only(right: 20)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../themes/app_color.dart';
import '../themes/app_text_styles.dart';

class MyTextField extends StatefulWidget {
  final String hintText;

  const MyTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;

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
        style: AppTextStyles.h5.copyWith(color: AppColors.white),
        obscureText: widget.hintText == 'Password' ? _obscureText : false,

        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyles.h5.copyWith(color: AppColors.white),
          border: InputBorder.none,
          prefix: const Padding(padding: EdgeInsets.only(left: 20)),
          suffixIcon: widget.hintText != 'Password'
              ? const SizedBox()
              : GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              ),
        ),
      ),
    );
  }
}

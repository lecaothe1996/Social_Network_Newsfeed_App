import 'package:flutter/material.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double? height;
  final double border;
  final Function(String)? onChanged;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final ScrollController? scrollController;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.border = 100,
    this.height,
    this.onChanged,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.keyboardType,
    this.scrollController,
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
      height: widget.height,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(widget.border),
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
          maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
          scrollController: widget.scrollController,
        style: AppTextStyles.h5.copyWith(color: AppColors.white),
        obscureText: widget.hintText == 'Password' ? _obscureText : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyles.h5.copyWith(color: AppColors.blueGrey),
          border: InputBorder.none,
          counter: const Offstage(),
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

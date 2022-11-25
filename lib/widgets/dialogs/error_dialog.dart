import 'package:flutter/material.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/themes/app_text_styles.dart';

class ErrorDialog {
  static void showMsgDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Lỗi',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          const Divider(height: 1),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ErrorDialog);
            },
            child: Text(
              'Ok',
              textAlign: TextAlign.center,
              style: AppTextStyles.h5.copyWith(color: AppColors.redMedium, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

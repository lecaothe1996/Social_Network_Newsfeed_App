import 'package:flutter/material.dart';
import 'package:social_app/themes/app_color.dart';
import 'package:social_app/widgets/button_widget.dart';

class ErrorDialog {
  static void showMsgDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Thông báo',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actionsPadding: const EdgeInsets.all(0),
        actions: [
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.blueGrey, width: 1)),
            ),
            child: MyElevatedButton(
              onPressed: () => Navigator.of(context).pop(ErrorDialog),
              text: 'Xác nhận',
              textColor: AppColors.redMedium,
              primary: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

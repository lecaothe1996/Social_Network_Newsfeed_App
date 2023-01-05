import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_app/themes/app_color.dart';

class LoadingDialog {
  static Future show(BuildContext context) {
    // Hide keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const Dialog(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            child: Center(
              child: SpinKitCircle(
                color: AppColors.white,
                size: 80,
              ),
            ),
          ),
        );
      }

    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}

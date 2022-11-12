import 'package:flutter/material.dart';

/// define color

class AppColors {
  static const Color transparent = Colors.transparent;
  static const Color redMedium = Color(0xfff54b64);
  static const Color tanHide = Color(0xFFF78361);
  static const Color blue = Color(0xff007AFF);
  static const Color orange = Color(0xffFF9500);
  static const Color purple = Color(0xff5856D6);
  static const Color tealBlue = Color(0xff5AC8FA);
  static const Color yellow = Color(0xffFFCC00);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color slate = Color(0xff4e586e);
  static const Color dark = Color(0xff242a37);
  static const Color textLogin = Color(0xffff2d55);
}

class Gradients {
  static const Gradient defaultGradientButton = LinearGradient(
    colors: [AppColors.redMedium, AppColors.tanHide],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.dark.withOpacity(0.28), AppColors.dark],
    stops: const [0.2, 0.8],
  );
}

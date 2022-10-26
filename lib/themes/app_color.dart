import 'package:flutter/material.dart';

/// define color

class AppColors {
  static const Color blue = Color(0xff007AFF);
  static const Color orange = Color(0xffFF9500);
  static const Color purple = Color(0xff5856D6);
  static const Color tealBlue = Color(0xff5AC8FA);
  static const Color yellow = Color(0xffFFCC00);
  static const Color white = Color(0xffffffff);
  static const Color slate = Color(0xff4e586e);
  static const Color dark = Color(0xff242a37);
  static const Color textLogin = Color(0xffff2d55);
}

class Gradients {
  static const Gradient defaultGradientButton = LinearGradient(
    colors: [Color(0xffF54B64), Color(0xffF78361)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  static Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [const Color(0xFF242A37).withOpacity(0.28), const Color(0xFF242A37)],
    stops: const [0.2, 0.8],
  );
}

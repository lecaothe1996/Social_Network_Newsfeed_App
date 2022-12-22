import 'package:flutter/material.dart';

class ScrollTopBottom {
  static void onTop(ScrollController scrollController) {
    if (scrollController.hasClients) {
      final position = scrollController.position.minScrollExtent;
      scrollController.animateTo(
        position,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutCirc,
      );
    }
  }

  static void onBottom(ScrollController scrollController) {
    if (scrollController.hasClients) {
      final position = scrollController.position.maxScrollExtent;
      scrollController.animateTo(
        position,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOutCirc,
      );
    }
  }
}
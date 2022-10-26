import 'package:flutter/material.dart';

class MyInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const MyInkWell({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Image.asset(
        'assets/images/icons/ic_facebook.png',
        color: Colors.white,
      ),
      onTap: onTap,
    );
  }
}

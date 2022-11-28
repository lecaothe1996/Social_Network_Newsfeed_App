import 'dart:async';

import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  final Function(bool) onTrigger;
  final Function(bool) onTap;
  final Widget deActivatedChild;
  final Widget activatedChild;
  final bool isActivated;
  final int delay;

  const Toggle({Key? key,
    required this.onTrigger,
    required this.onTap,
    required this.deActivatedChild,
    required this.activatedChild,
    this.isActivated = false,
    this.delay = 300,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Toggle> createState() => _ToggleState(isActivated);
}

class _ToggleState extends State<Toggle> {
  late bool _isOn;
  int _count = 0;
  Timer? _debounce;

  _ToggleState(bool isActivated) {
    _isOn = isActivated;
  }

  @override
  void didUpdateWidget(covariant Toggle oldWidget) {
    if (oldWidget.isActivated != widget.isActivated) {
      _isOn = widget.isActivated;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOn = !_isOn;
          _count++;
        });

        widget.onTap(_isOn);

        if (_debounce?.isActive ?? false) {
          _debounce!.cancel();
        }

        _debounce = Timer(Duration(milliseconds: widget.delay), () {
          if (_count % 2 == 1) {
            _count = 0;
            widget.onTrigger(_isOn);
          }
        });
      },
      child: _isOn ? widget.activatedChild : widget.deActivatedChild,
    );
  }
}

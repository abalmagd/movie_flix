import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    Key? key,
    required this.child,
    this.blurStrength = 4,
    this.borderRadius = 24,
    this.center = false,
    this.tightPadding = false,
  }) : super(key: key);

  final Widget? child;
  final double blurStrength;
  final double borderRadius;
  final bool tightPadding;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return child == null
        ? const SizedBox.shrink()
        : ClipRRect(
          borderRadius:
              BorderRadius.circular(tightPadding ? borderRadius : 4),
          clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blurStrength,
              sigmaY: blurStrength,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: tightPadding ? 0 : 4,
                horizontal: tightPadding ? 0 : 6,
              ),
              child: center ? Center(child: child) : child,
            ),
          ),
        );
  }
}

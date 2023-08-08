import 'dart:ui';

import 'package:flutter/material.dart';

import '../../config/theme/palette.dart';

class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    Key? key,
    required this.child,
    this.blurStrength = 6,
    this.borderRadius = 8,
    this.outerPadding = EdgeInsets.zero,
    this.innerPadding = EdgeInsets.zero,
    this.backgroundColor = Palette.black,
    this.borderRadiusGeometry,
  }) : super(key: key);

  final Widget child;
  final double blurStrength;
  final double borderRadius;
  final EdgeInsets innerPadding;
  final EdgeInsets outerPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadiusGeometry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding,
      child: ClipRRect(
        borderRadius:
            borderRadiusGeometry ?? BorderRadius.circular(borderRadius),
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurStrength,
            sigmaY: blurStrength,
          ),
          child: Container(
            padding: innerPadding,
            color: backgroundColor?.withOpacity(0.4),
            child: child,
          ),
        ),
      ),
    );
  }
}

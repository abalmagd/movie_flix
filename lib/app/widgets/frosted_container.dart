import 'dart:ui';

import 'package:flutter/material.dart';

import '../environment/spacing.dart';

class FrostedContainer extends StatelessWidget {
  const FrostedContainer({
    Key? key,
    required this.child,
    this.blurStrength = Spacing.s4,
    this.borderRadius = Spacing.s24,
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
        : Padding(
            padding: const EdgeInsets.all(Spacing.s4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              clipBehavior: Clip.hardEdge,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurStrength,
                  sigmaY: blurStrength,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: tightPadding ? Spacing.s0 : Spacing.s4,
                    horizontal: tightPadding ? Spacing.s0 : Spacing.s8,
                  ),
                  child: center ? Center(child: child) : child,
                ),
              ),
            ),
          );
  }
}

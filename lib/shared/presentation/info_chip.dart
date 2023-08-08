import 'package:flutter/material.dart';

import '../../config/theme/palette.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.text,
    this.backgroundColor = Palette.black,
    this.borderColor = Palette.white,
    this.noOpacity = false,
  });

  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final bool noOpacity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(noOpacity ? 1 : 0.4),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(color: Palette.white),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ThemeIconButton extends StatelessWidget {
  const ThemeIconButton({
    Key? key,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.dark_mode),
      splashRadius: 20,
      color: color,
    );
  }
}

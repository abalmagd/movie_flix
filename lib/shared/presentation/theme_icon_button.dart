import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/riverpod/config_controller.dart';

class ThemeIconButton extends ConsumerWidget {
  const ThemeIconButton({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(configControllerProvider.notifier).changeThemeMode(context);
      },
      icon: const Icon(Icons.dark_mode),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      splashRadius: 20,
      color: color,
    );
  }
}

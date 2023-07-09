import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/shared/presentation/theme_icon_button.dart';

import '../../features/auth/presentation/riverpod/auth_controller.dart';

class PrimaryAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
  }) : super(key: key);

  final String title;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final auth = ref.read(authControllerProvider);
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleLarge
            ?.copyWith(color: theme.colorScheme.primary),
      ),
      centerTitle: centerTitle,
      actions: const [ThemeIconButton()],
    );
  }
}

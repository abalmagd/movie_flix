import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/shared/presentation/theme_icon_button.dart';

class PrimaryAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    Key? key,
    this.title = '',
    this.centerTitle = true,
    this.titleWidget,
  }) : super(key: key);

  final String title;
  final bool centerTitle;
  final Widget? titleWidget;

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppBar(
      title: titleWidget ??
          Text(
            title,
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.primary),
          ),
      centerTitle: centerTitle,
      actions: const [ThemeIconButton()],
    );
  }
}

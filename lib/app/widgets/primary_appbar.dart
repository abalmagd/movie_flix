import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/widgets/theme_icon_button.dart';

import '../riverpod/auth/auth_controller.dart';
import '../riverpod/config/config_controller.dart';

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
    final call = ref.read(configControllerProvider.notifier);
    final auth = ref.read(authControllerProvider);
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleLarge
            ?.copyWith(color: theme.colorScheme.primary),
      ),
      centerTitle: centerTitle,
      actions: [
        ThemeIconButton(
          onPressed: () => call.changeThemeMode(context),
        ),
        IconButton(
          onPressed: () {
            /*auth.session.value.isGuest ? Utils.toast(message: 'Guest Session')
                : null;*/
          },
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}

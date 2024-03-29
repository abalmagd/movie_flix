import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/config/constants.dart';
import 'package:movie_flix/config/riverpod/config_controller.dart';
import 'package:movie_flix/shared/presentation/drawer/drawer_button.dart';
import 'package:movie_flix/utils/assets.dart';
import 'package:movie_flix/utils/strings.dart';

import '../../../config/theme/palette.dart';
import '../../../features/auth/presentation/riverpod/auth_controller.dart';

class PrimaryDrawer extends ConsumerWidget {
  const PrimaryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final auth = ref.watch(authControllerProvider);
    final profile = auth.value!.session.profile;
    final config = ref.watch(configControllerProvider);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: Drawer(
        child: Column(
          children: [
            // Header Image
            SizedBox(
              height: size.height * Constants.drawerHeaderHeightFactor,
              width: double.infinity,
              child: Image.network(
                config.themeMode == ThemeMode.dark
                    ? Assets.tempImageRed
                    : Assets.tempImageBlue,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            // Header
            ListTile(
              title: Text(
                profile.name.isEmpty ? 'Username' : profile.name,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                profile.username,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundColor: Palette.neutral,
                foregroundImage: NetworkImage(profile.avatar.gravatar),
                child: const Icon(Icons.person),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              splashColor: theme.colorScheme.primary,
              onTap: () {},
            ),
            // Home
            PrimaryDrawerButton(
              text: Strings.home,
              icon: Icons.home,
              route: '/',
              onTap: () => currentRoute == '/' ? Navigator.pop(context) : null,
            ),
            const Spacer(),
            // Logout
            PrimaryDrawerButton(
              text: Strings.logout,
              icon: Icons.logout,
              isLoading: auth is AsyncLoading,
              onTap: ref.read(authControllerProvider.notifier).logout,
            ),
          ],
        ),
      ),
    );
  }
}

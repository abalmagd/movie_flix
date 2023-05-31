import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/environment/assets.dart';
import 'package:movie_flix/app/environment/constants.dart';
import 'package:movie_flix/app/environment/strings.dart';
import 'package:movie_flix/app/riverpod/config/config_controller.dart';
import 'package:movie_flix/app/widgets/drawer/drawer_button.dart';

import '../../environment/spacing.dart';
import '../../riverpod/auth/auth_controller.dart';
import '../../theme/palette.dart';

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
            width: Spacing.s2,
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
              trailing: const Icon(Icons.arrow_forward_ios, size: Spacing.s16),
              splashColor: theme.colorScheme.primary,
              onTap: () {},
            ),
            // Home
            DrawerButton(
              text: Strings.home,
              icon: Icons.home,
              route: '/',
              onTap: () => currentRoute == '/' ? Navigator.pop(context) : null,
            ),
            const Spacer(),
            // Logout
            DrawerButton(
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

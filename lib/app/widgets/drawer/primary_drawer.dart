import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flix/app/environment/assets.dart';
import 'package:movie_flix/app/environment/constants.dart';
import 'package:movie_flix/app/environment/strings.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';
import 'package:movie_flix/app/riverpod/config/config_controller.dart';
import 'package:movie_flix/app/widgets/drawer/drawer_button.dart';

import '../../environment/spacing.dart';
import '../../features/home/home_screen.dart';
import '../../theme/palette.dart';

class PrimaryDrawer extends ConsumerWidget {
  const PrimaryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final auth = ref.watch(authControllerProvider);
    final config = ref.watch(configControllerProvider);
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
            SizedBox(
              height: size.height * Constants.drawerHeaderHeightFactor,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    config.themeMode == ThemeMode.dark
                        ? Assets.tempImageRed
                        : Assets.tempImageBlue,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: Spacing.s10,
                        sigmaY: Spacing.s10,
                      ),
                      child: Container(color: Palette.transparent),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: Spacing.s30,
                        backgroundColor: Palette.neutral,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(height: Spacing.s8),
                      Text(
                        auth.session.value!.isGuest
                            ? Strings.guestSession
                            : Strings.guestSession,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Palette.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: theme.colorScheme.primary, height: Spacing.s0),
            DrawerButton(
              text: Strings.home,
              icon: Icons.home,
              color: GoRouter.of(context).location == HomeScreen.route
                  ? theme.colorScheme.primary
                  : null,
              onTap: () {},
            ),
            const Spacer(),
            DrawerButton(
              text: Strings.logout,
              icon: Icons.logout,
              onTap: () => ref.read(authControllerProvider.notifier).logout(),
            ),
          ],
        ),
      ),
    );
  }
}

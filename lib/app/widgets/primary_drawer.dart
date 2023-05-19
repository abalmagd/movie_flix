import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/environment/constants.dart';
import 'package:movie_flix/app/environment/strings.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';
import 'package:movie_flix/app/widgets/primary_button.dart';

import '../environment/spacing.dart';
import '../theme/palette.dart';

class PrimaryDrawer extends ConsumerWidget {
  const PrimaryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final auth = ref.read(authControllerProvider);
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
            Container(
              height: size.height * Constants.drawerHeaderHeightFactor,
              width: double.infinity,
              color: theme.colorScheme.primary,
              child: Column(
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
                  ),
                ],
              ),
            ),
            Divider(color: theme.colorScheme.primary, height: Spacing.s0),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              splashColor: theme.colorScheme.primary,
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              splashColor: theme.colorScheme.primary,
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).logout(),
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}

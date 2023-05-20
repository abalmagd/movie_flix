import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_flix/app/environment/spacing.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';
import 'package:movie_flix/app/widgets/primary_app_bar.dart';
import 'package:movie_flix/core/extensions.dart';

import '../../environment/assets.dart';
import '../../environment/constants.dart';
import '../../environment/strings.dart';
import '../../widgets/primary_button.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static const route = '/landing';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final brightness = Theme.of(context).brightness;
    final auth = ref.watch(authControllerProvider);
    final call = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: const PrimaryAppBar(title: Strings.appName),
      body: Column(
        children: [
          Text(
            Strings.letsFindAMovie,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: SvgPicture.asset(
              brightness == Brightness.dark
                  ? Assets.landingImageDark
                  : Assets.landingImageLight,
            ),
          ),
          PrimaryButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => const RedirectBottomSheet(),
              );
            },
            isLoading: auth.session is AsyncLoading,
            text: Strings.login,
          ),
          TextButton(
            onPressed: auth.session is AsyncLoading
                ? null
                : () async => await call.loginAsGuest(),
            child: const Text(Strings.continueAsGuest),
          ),
        ],
      ),
    );
  }
}

class RedirectBottomSheet extends ConsumerWidget {
  const RedirectBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * Constants.redirectBottomSheetHeightFactor,
      padding: const EdgeInsets.all(Spacing.s16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.s28),
        color: theme.scaffoldBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.headsUp, style: theme.textTheme.titleLarge),
          const SizedBox(height: Spacing.s4),
          const Text(Strings.redirectWarning),
          Expanded(
            child: SvgPicture.string(
              Assets.redirect.replaceAll(
                Constants.defaultSvgColor,
                theme.colorScheme.primary.toHex(),
              ),
            ),
          ),
          PrimaryButton(
            onPressed: () => ref.read(authControllerProvider.notifier).login(),
            width: double.infinity,
            text: Strings.confirm,
          ),
        ],
      ),
    );
  }
}

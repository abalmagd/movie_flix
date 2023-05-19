import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';
import 'package:movie_flix/app/widgets/primary_app_bar.dart';

import '../../environment/assets.dart';
import '../../environment/strings.dart';
import '../../widgets/primary_button.dart';
import '../auth/login_screen.dart';

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
            onPressed: () => context.pushNamed(LoginScreen.route),
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

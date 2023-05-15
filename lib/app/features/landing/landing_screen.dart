import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flix/app/features/home/home_screen.dart';
import 'package:movie_flix/app/widgets/primary_app_bar.dart';

import '../../environment/assets.dart';
import '../../environment/strings.dart';
import '../../widgets/primary_button.dart';
import '../auth/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  static const route = '/landing';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = Theme.of(context).brightness;
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
            onPressed: () => context.go(LoginScreen.route),
            text: Strings.login,
          ),
          TextButton(
            onPressed: () => context.go(HomeScreen.route),
            child: const Text(Strings.continueAsGuest),
          ),
        ],
      ),
    );
  }
}

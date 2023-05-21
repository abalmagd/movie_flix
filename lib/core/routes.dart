import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flix/app/features/landing/landing_screen.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';

import '../app/environment/strings.dart';
import '../app/features/home/home_screen.dart';
import '../app/models/session.dart';

class Routing {
  static GoRouter router(WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    return GoRouter(
      initialLocation: LandingScreen.route,
      debugLogDiagnostics: true,
      errorBuilder: (context, state) => const BadRouteScreen(),
      redirect: (context, state) {
        if (auth.session != Session.empty &&
            state.location == LandingScreen.route) {
          return HomeScreen.route;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: LandingScreen.route,
          name: LandingScreen.route,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: HomeScreen.route,
          builder: (context, state) => HomeScreen(),
        ),
      ],
    );
  }
}

class BadRouteScreen extends StatelessWidget {
  const BadRouteScreen({Key? key}) : super(key: key);
  static const route = '/undefined-route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.noRouteFound),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(Strings.noRouteFound),
      ),
    );
  }
}

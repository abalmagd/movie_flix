import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_flix/app/features/landing/landing_screen.dart';

import '../app/environment/strings.dart';
import '../app/features/auth/login_screen.dart';
import '../app/features/home/home_screen.dart';

class Routing {
  static final router = GoRouter(
    initialLocation: '/landing',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const BadRouteScreen(),
    routes: [
      GoRoute(
        path: LandingScreen.route,
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: LoginScreen.route,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.route,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
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

import 'package:flutter/material.dart';
import 'package:movie_flix/features/auth/presentation/landing_screen.dart';

import '../utils/strings.dart';
import '../features/home/presentation/home_screen.dart';

class Routing {
  static final routes = {
    LandingScreen.route: (context) => const LandingScreen(),
    HomeScreen.route: (context) => const HomeScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LandingScreen.route:
        return MaterialPageRoute(builder: (context) => const LandingScreen());
      case HomeScreen.route:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const BadRouteScreen());
    }
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/config/theme/custom_theme.dart';
import 'package:movie_flix/features/auth/presentation/auth_screen.dart';
import 'package:movie_flix/features/home/presentation/home_screen.dart';
import 'package:movie_flix/utils/life_cycle_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/riverpod/config_controller.dart';
import 'config/routes.dart';
import 'features/auth/domain/session.dart';
import 'features/auth/presentation/riverpod/auth_controller.dart';
import 'shared/data/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configControllerProvider);
    final auth = ref.watch(authControllerProvider);
    bool isLogged = auth.value?.session != Session.empty;
    return AppLifeCycleWrapper(
      ref: ref,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MaterialApp(
          title: 'MovieFlix',
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme(context),
          themeMode: config.themeMode,
          darkTheme: CustomTheme.darkTheme(context),
          routes: Routing.routes,
          onGenerateRoute: Routing.onGenerateRoute,
          home: isLogged ? const HomeScreen() : const AuthScreen(),
        ),
      ),
    );
  }
}

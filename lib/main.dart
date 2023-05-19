import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/riverpod/config/config_controller.dart';
import 'core/local_storage.dart';
import 'core/routes.dart';

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MaterialApp.router(
        title: 'MovieFlix',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme(context),
        themeMode: config.themeMode,
        darkTheme: CustomTheme.darkTheme(context),
        routerConfig: Routing.router(ref),
      ),
    );
  }
}

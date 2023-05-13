import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_flix/app/environment/spacing.dart';

import 'palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          Palette.red500.value,
          const {
            100: Palette.red100,
            200: Palette.red200,
            300: Palette.red300,
            400: Palette.red400,
            500: Palette.red500,
            600: Palette.red600,
            700: Palette.red700,
            800: Palette.red800,
            900: Palette.red900,
          },
        ),
        accentColor: Palette.red300,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Palette.almostBlack,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Palette.white),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Palette.transparent,
      ),
      textTheme: theme.textTheme.apply(
        displayColor: Palette.white,
        bodyColor: Palette.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Palette.red500,
          disabledBackgroundColor: Palette.red300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.s8),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(color: Palette.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: theme.textTheme.titleSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.s8),
          ),
        ),
      ),
      splashColor: Palette.white,
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          Palette.blue500.value,
          const {
            100: Palette.blue100,
            200: Palette.blue200,
            300: Palette.blue300,
            400: Palette.blue400,
            500: Palette.blue500,
            600: Palette.blue600,
            700: Palette.blue700,
            800: Palette.blue800,
            900: Palette.blue900,
          },
        ),
        accentColor: Palette.blue300,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Palette.grey50,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Palette.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Palette.grey50,
      ),
      textTheme: theme.primaryTextTheme.apply(
        displayColor: Palette.black,
        bodyColor: Palette.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Palette.blue500,
          disabledBackgroundColor: Palette.blue300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.s8),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(color: Palette.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: theme.textTheme.titleSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.s8),
          ),
        ),
      ),
    );
  }
}

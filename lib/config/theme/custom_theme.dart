import 'package:flutter/material.dart';
import 'package:movie_flix/config/constants.dart';

import 'palette.dart';

class CustomTheme {
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
      drawerTheme: DrawerThemeData(
        backgroundColor: Palette.almostBlack,
        width: size.width * Constants.drawerWidthFactor,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Palette.red500,
          disabledBackgroundColor: Palette.red300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(color: Palette.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: theme.textTheme.titleSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      splashColor: Palette.white,
      iconTheme: const IconThemeData(color: Palette.white),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Palette.white,
        ),
      ),
      tabBarTheme: const TabBarTheme(dividerColor: Palette.neutral),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
      drawerTheme: DrawerThemeData(
        backgroundColor: Palette.grey50,
        width: size.width * Constants.drawerWidthFactor,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Palette.blue500,
          disabledBackgroundColor: Palette.blue300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: theme.textTheme.labelLarge?.copyWith(color: Palette.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: theme.textTheme.titleSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Palette.black),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: Palette.black,
        ),
      ),
      tabBarTheme: const TabBarTheme(dividerColor: Palette.neutral),
    );
  }
}

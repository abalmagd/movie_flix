import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/data/local_storage.dart';
import '../../utils/utils.dart';
import 'config_state.dart';

final configControllerProvider =
    NotifierProvider<ConfigController, ConfigState>(ConfigController.new);

class ConfigController extends Notifier<ConfigState> {
  late final SharedPrefs _sharedPrefs;

  @override
  ConfigState build() {
    _sharedPrefs = ref.read(sharedPrefsProvider);

    final ThemeMode themeMode = getThemeMode() ?? ThemeMode.dark;

    Utils.logPrint(message: 'Building $runtimeType');

    return ConfigState(themeMode: themeMode);
  }

  ThemeMode? getThemeMode() {
    final localThemeMode = _sharedPrefs.get(key: SharedPrefsKeys.themeMode);

    return EnumToString.fromString(
      ThemeMode.values,
      localThemeMode == null ? 'dark' : localThemeMode as String,
    );
  }

  void changeThemeMode(BuildContext context) async {
    switch (state.themeMode) {
      case ThemeMode.system:
        state = MediaQuery.of(context).platformBrightness == Brightness.light
            ? state.copyWith(themeMode: ThemeMode.dark)
            : state.copyWith(themeMode: ThemeMode.light);
        break;
      case ThemeMode.light:
        state = state.copyWith(themeMode: ThemeMode.dark);
        break;
      case ThemeMode.dark:
        state = state.copyWith(themeMode: ThemeMode.light);
        break;
    }

    _sharedPrefs.set(
      key: SharedPrefsKeys.themeMode,
      value: EnumToString.convertToString(state.themeMode),
    );

    Utils.logPrint(message: 'Theme Mode changed to ${state.themeMode}');
  }
}

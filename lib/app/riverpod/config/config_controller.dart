import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/local_storage.dart';
import 'config_state.dart';

final configControllerProvider =
    StateNotifierProvider.autoDispose<ConfigController, ConfigState>(
  (ref) {
    return ConfigController(
      const ConfigState(),
      ref.watch(sharedPrefsProvider),
    );
  },
);

class ConfigController extends StateNotifier<ConfigState> {
  ConfigController(ConfigState state, this._sharedPrefs) : super(state) {
    getThemeMode();
  }

  final SharedPrefs _sharedPrefs;

  @override
  void dispose() {
    /*Comment to hide warning*/
    super.dispose();
  }

  void getThemeMode() {
    final localThemeMode = _sharedPrefs.get(key: SharedPrefsKeys.themeMode);

    state = state.copyWith(
      themeMode: EnumToString.fromString(
        ThemeMode.values,
        localThemeMode == null ? 'system' : localThemeMode as String,
      ),
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
  }
}

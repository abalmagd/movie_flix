import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedPrefsProvider = Provider<SharedPrefs>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedPrefs(sharedPreferences: sharedPrefs);
});

class SharedPrefs implements SharedPrefsKeys {
  SharedPrefs({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  Future<bool> set({
    required String key,
    required value,
  }) {
    if (value is String) return sharedPreferences.setString(key, value);

    if (value is bool) return sharedPreferences.setBool(key, value);

    if (value is int) return sharedPreferences.setInt(key, value);

    if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    }

    return sharedPreferences.setDouble(key, value);
  }

  Object? get({required String key}) => sharedPreferences.get(key);

  Future<bool> remove({required String key}) async =>
      await sharedPreferences.remove(key);

  Future<bool> clear() async => await sharedPreferences.clear();
}

class SharedPrefsKeys {
  static const themeMode = 'themeMode';
  static const session = 'session';
  static const requestToken = 'requestToken';
}

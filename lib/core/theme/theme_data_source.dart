import 'package:hive/hive.dart';

class ThemeDataSource {
  final Box settingsBox = Hive.box('settings');

  bool loadTheme() {
    return settingsBox.get(
      'isDark',
      defaultValue: false,
    );
  }

  Future<void> saveTheme(
    bool isDark,
  ) async {
    await settingsBox.put(
      'isDark',
      isDark,
    );
  }
}
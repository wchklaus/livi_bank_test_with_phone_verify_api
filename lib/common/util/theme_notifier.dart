import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  static bool isDark = false;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isDark) {
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

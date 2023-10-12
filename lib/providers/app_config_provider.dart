import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  late String appLanguage;
  late String themeMode;
  static String themeKey = "theme";
  static String languageKey = "language";
  SharedPreferences? _prefs;
  AppConfigProvider() {
    appLanguage = "en";
    themeMode = "dark";

    loadFromSharedPreferences();
  }
  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    saveToSharedPreferences();
    notifyListeners();
  }

  void changeThemeMode(String newThemeMode) {
    if (themeMode == newThemeMode) {
      return;
    }
    themeMode = newThemeMode;
    saveToSharedPreferences();
    notifyListeners();
  }

  bool isDarkTheme() => themeMode == "dark";

  initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  loadFromSharedPreferences() async {
    await initSharedPreferences();
    themeMode = _prefs!.getString(themeKey) ?? "dark";
    appLanguage = _prefs!.getString(languageKey) ?? "en";
    notifyListeners();
  }

  saveToSharedPreferences() async {
    await initSharedPreferences();
    await _prefs!.setString(themeKey, themeMode);
    await _prefs!.setString(languageKey, appLanguage);
  }
}

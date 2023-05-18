import 'package:flutter/foundation.dart';
import 'package:places/theme_provider.dart';
import 'package:places/ui/screen/res/themes.dart';

enum Theme { dark, light }

class SettingsInteractor with ChangeNotifier {
  static final SettingsInteractor _instance = SettingsInteractor._internal();

  factory SettingsInteractor({required ThemeProvider themeProvider}) {
    _themeProvider = themeProvider;
    return _instance;
  }

  SettingsInteractor._internal();

  static late final ThemeProvider _themeProvider;

  void swipeTheme() {
    _themeProvider.changeTheme();
    notifyListeners();
  }

  bool get isLight => _themeProvider.isLight;
  BaseTheme get appTheme => _themeProvider.isLight ? LightTheme() : DarkTheme();
}

import 'package:flutter/widgets.dart';
import 'package:places/ui/screen/res/themes.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLight = true;

  void changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }

  BaseTheme get appTheme => isLight ? LightTheme() : DarkTheme();
}

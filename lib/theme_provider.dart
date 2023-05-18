import 'package:places/ui/screen/res/themes.dart';

class ThemeProvider {
  bool isLight = true;

  void changeTheme() {
    isLight = !isLight;
  }

  BaseTheme get appTheme => isLight ? LightTheme() : DarkTheme();
}

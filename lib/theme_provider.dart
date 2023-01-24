import 'package:places/ui/screen/res/themes.dart';

class ThemeProvider {
  bool isLight = true;

  BaseTheme get appTheme => isLight ? LightTheme() : DarkTheme();
}

import 'package:flutter/material.dart';
import 'package:places/theme_provider.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/visiting_screen.dart';

final themeProvider = ThemeProvider();

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Surf",
        theme: themeProvider.isLight ? lightTheme : darkTheme,
        home: const VisitingScreen());
  }
}

import 'package:flutter/material.dart';
import 'package:places/theme_provider.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

final themeProvider = ThemeProvider();

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => themeProvider,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: ((context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Surf",
            theme: theme.isLight ? lightTheme : darkTheme,
            home: const FilterScreen(),
          )),
    );
  }
}

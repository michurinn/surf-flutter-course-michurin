import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/theme_provider.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

final themeProvider = ThemeProvider();
final filter = Filter();

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
            home: const SightListScreen(),
          )),
    );
  }
}

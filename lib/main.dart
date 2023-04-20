import 'package:flutter/material.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/sight.dart';
import 'package:places/theme_provider.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/categories_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
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
            initialRoute: SplashScreen.routeName,
            routes: {
              VisitingScreen.routeName: (context) => const VisitingScreen(),
              SplashScreen.routeName: (context) => const SplashScreen(),
              SightListScreen.routeName: (context) => const SightListScreen(),
              SettingScreen.routeName: (context) => const SettingScreen(),
              OnboardingScreen.routeName: (context) => const OnboardingScreen(),
              FilterScreen.routeName: (context) => const FilterScreen(),
              CategoriesScreen.routeName: (context) => const CategoriesScreen(),
              AddSightScreen.routeName: (context) => const AddSightScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
            },
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case SightSearchScreen.routeName:
                  final List<Sight> filteredPlaces =
                      settings.arguments as List<Sight>;
                  return MaterialPageRoute(
                      settings: settings,
                      builder: (context) => SightSearchScreen(
                            filteredPlaces: filteredPlaces,
                          ));
                default:
                  return null;
              }
            },
          )),
    );
  }
}

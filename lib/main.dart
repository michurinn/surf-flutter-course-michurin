import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/dio_client.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
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
final PlaceInteractor placeInteractor = PlaceInteractor(
  PlaceRepository(
    httpClient: DioClient(),
  ),
);
//Интерактор поиска, пока объявляем здесь на всё приложение
final SearchInteractor searchInteractor = SearchInteractor(
  PlaceRepository(
    httpClient: DioClient(),
  ),
);
final SettingsInteractor themeInteractor =
    SettingsInteractor(themeProvider: themeProvider);

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
                  final List<Place> filteredPlaces =
                      settings.arguments as List<Place>;
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

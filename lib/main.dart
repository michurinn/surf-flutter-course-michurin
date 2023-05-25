import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/dio_client.dart';
import 'package:places/data/interactor/settings_interactor.dart';
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        RepositoryProvider<IPlaceRepository>(
          create: (context) => PlaceRepository(httpClient: DioClient()),
        ),
        Provider<PlaceInteractor>(
          create: (context) => PlaceInteractor(
            context.read<IPlaceRepository>(),
          ),
        ),
        Provider<SearchInteractor>(
          create: (context) => SearchInteractor(
            context.read<IPlaceRepository>(),
          ),
        ),
        ChangeNotifierProvider<SettingsInteractor>(
          create: (_) => SettingsInteractor(themeProvider: ThemeProvider()),
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsInteractor>(
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
                  return MaterialPageRoute(
                      settings: settings,
                      builder: (context) => const SightSearchScreen());
                default:
                  return null;
              }
            },
          )),
    );
  }
}

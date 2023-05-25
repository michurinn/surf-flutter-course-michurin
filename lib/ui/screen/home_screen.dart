import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/bloc/planned_bloc/planned_places_bloc.dart';
import 'package:places/data/bloc/visited_bloc/bloc/visited_places_bloc.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/data/repository/planned_repository.dart';
import 'package:places/data/repository/planned_repository_interface.dart';
import 'package:places/data/repository/visited_repository.dart';
import 'package:places/data/repository/visited_repository_interface.dart';
import 'package:places/data/store/sight_list_store.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home_screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    return Scaffold(
      // Используется в SightListScreen() и VisitingScreen()
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IPlannedRepository>(
            create: (context) => FavoriteRepository(),
          ),
          RepositoryProvider<IVisitedRepository>(
            create: (context) => VisitedRepository(),
          ),
        ],
        // Используется в SightListScreen() и VisitingScreen()
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PlannedPlacesBloc>(
              create: (context) => PlannedPlacesBloc(
                favoritePlacesRepository: context.read<IPlannedRepository>(),
              )..add(const PlannedPlacesEvent.load()),
            ),
            BlocProvider<VisitedPlacesBloc>(
              create: (context) => VisitedPlacesBloc(
                visitedPlacesRepository: context.read<IVisitedRepository>(),
              )..add(const VisitedPlacesEvent.load()),
            ),
          ],
          child: TabBarView(controller: _tabController, children: [
            Provider<SightListStore>(
              create: (context) =>
                  SightListStore(context.read<IPlaceRepository>()),
              builder: (context, child) => const SightListScreen(),
            ),
            const SizedBox.shrink(), // Map screen
            const VisitingScreen(),
            const SettingScreen(),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _tabController.animateTo,
        currentIndex: _tabController.index,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            activeIcon: SvgPicture.asset(
              AppAssets.listFilled,
              color: themeProvider.bottomNavBarSelectedItemColor,
            ),
            label: 'List of Places',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: SvgPicture.asset(
              AppAssets.mapFilled,
              color: themeProvider.bottomNavBarSelectedItemColor,
            ),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.like,
              color: themeProvider.bottomNavBarUnselectedItemColor,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.likeFilled,
              color: themeProvider.bottomNavBarSelectedItemColor,
            ),
            label: 'Favorite places',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

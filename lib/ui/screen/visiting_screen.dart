
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/favorite_card.dart';

// Екран Хочу посетить/Посещённые
class VisitingScreen extends StatefulWidget {
  const VisitingScreen({super.key});

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: const _FavoriteAppBar(),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: const [
                      SizedBox(height: 30),
                      _FavoriteSightMocks(),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: const [
                      SizedBox(height: 30),
                      _FavoriteSightMocks(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 2,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list_alt),
                activeIcon: SvgPicture.asset(
                  AppAssets.listFilled,
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
                ),
                label: 'List of Places',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.map_outlined),
                activeIcon: SvgPicture.asset(
                  AppAssets.mapFilled,
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
                ),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.like,
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
                ),
                activeIcon: SvgPicture.asset(
                  AppAssets.likeFilled,
                  color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
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
        ));
  }
}

class _FavoriteSightMocks extends StatefulWidget {
  const _FavoriteSightMocks({
    Key? key,
  }) : super(key: key);

  @override
  State<_FavoriteSightMocks> createState() => _FavoriteSightMocksState();
}

class _FavoriteSightMocksState extends State<_FavoriteSightMocks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: mocks
          .expand(
            (element) => [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Card(
                      child: Container(
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: themeProvider.appTheme.errorColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.bucket,
                                color: AppColors.white,
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Удалить",
                                style: AppTypography.small
                                    .copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Dismissible(
                    key: ValueKey<int>(element.hashCode),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      mocks.remove(element);
                      setState(() {});
                    },
                    child: DragTarget(
                      onAccept: (data) {
                        ValueKey<String> rawData = data as ValueKey<String>;

                        setState(() {
                          mocks.insert(
                            mocks.indexOf(element),
                            mocks.removeAt(
                              mocks.indexWhere(
                                (element) =>
                                    element.name == rawData.value.toString(),
                              ),
                            ),
                          );
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return LongPressDraggable(
                          data: ValueKey<String>(element.name),
                          axis: Axis.vertical,
                          feedback: Opacity(
                            opacity: 0.8,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: FavoriteSight(
                                sight: element,
                                isFinished: false,
                              ),
                            ),
                          ),
                          child: FavoriteSight(
                            sight: element,
                            isFinished: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )
          .toList(),
    );
  }
}

class _FavoriteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _FavoriteAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title:
          const Text(AppStrings.favoritePlaces, style: AppTypography.subtitle),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: themeProvider.appTheme.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            child: TabBar(
              splashBorderRadius: const BorderRadius.all(Radius.circular(40.0)),
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              tabs: const [
                Text(AppStrings.wouldLikeToVisit),
                Text(AppStrings.justVisited),
              ],
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 108);
}

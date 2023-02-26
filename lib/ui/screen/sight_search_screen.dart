import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({super.key, required this.filteredPlaces});

  final List<Sight> filteredPlaces;

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late TextEditingController? controller;
  bool showHistory = true;
  List<Sight>? results;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: _AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(
                searchRequest: (str) => _findSight(str),
                isFocused: true,
                isEnabled: true,
                clearHistory: () => setState(
                  () {
                    showHistory = false;
                  },
                ),
                showHistory: () => setState(
                  () {
                    showHistory = true;
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              showHistory
                  ? _PreviuousSearchList(
                      clearHistory: () => setState(
                        () {
                          showHistory = false;
                        },
                      ),
                    )
                  : (results == null || results!.isEmpty)
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 180.0),
                          child: _CantFindIt(),
                        )
                      : Column(
                          children: results!
                              .expand(
                                (element) => [
                                  _ListItem(sight: element),
                                ],
                              )
                              .toList(),
                        ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              color: themeProvider.appTheme.bottomNavBarUnselectedItemColor,
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
    );
  }

  _findSight(String str) {
    List<Sight> res = widget.filteredPlaces
        .where((element) =>
            element.name.toUpperCase().contains(str.toUpperCase().trim()))
        .toList();
    history.add(str);
    setState(
      () {
        results = res;
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.sight});
  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SightDetails(
            sight: sight,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.network(
                        sight.imagePath,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 6.0,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ).image),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sight.name,
                    style: AppTypography.formLabel.copyWith(
                        color: themeProvider
                            .appTheme.bottomNavBarSelectedItemColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    sight.type,
                    style: AppTypography.smallGreen
                        .copyWith(color: AppColors.whiteSecondary2),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            thickness: 0.8,
            color: AppColors.inactiveBlack,
            indent: 70,
          ),
        ],
      ),
    );
  }
}

class _PreviuousSearchList extends StatefulWidget {
  const _PreviuousSearchList({this.clearHistory});
  final VoidCallback? clearHistory;
  @override
  State<_PreviuousSearchList> createState() => __PreviuousSearchListState();
}

class __PreviuousSearchListState extends State<_PreviuousSearchList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.youFound.toUpperCase(),
          style:
              AppTypography.superSmall.copyWith(color: AppColors.inactiveBlack),
        ),
        Column(
          children: history
              .expand(
                (element) => [
                  HistoryItem(
                    text: element,
                    delete: () {
                      history.remove(element);
                      setState(
                        () {},
                      );
                    },
                  ),
                  const Divider(thickness: 0.8, color: AppColors.inactiveBlack),
                ],
              )
              .toList(),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                //history.clear();
                widget.clearHistory!();
              });
            },
            child: Text(AppStrings.clearHistore,
                style: AppTypography.simpleText
                    .copyWith(color: themeProvider.appTheme.filterButtonColor)))
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.listOfInterestingPlases,
        style: AppTypography.subtitle,
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  const HistoryItem({super.key, required this.text, required this.delete});
  final String text;
  final VoidCallback delete;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppTypography.formLabel
              .copyWith(color: AppColors.whiteSecondary2),
        ),
        IconButton(
          onPressed: () {
            delete();
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: AppColors.whiteSecondary2,
          ),
        )
      ],
    );
  }
}

List<String> history = ["Мок1"];

class _CantFindIt extends StatelessWidget {
  const _CantFindIt();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.search_rounded,
          color: AppColors.inactiveBlack,
          size: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0, bottom: 8),
          child: Text(
            AppStrings.nothingFinded,
            style:
                AppTypography.subtitle.copyWith(color: AppColors.inactiveBlack),
          ),
        ),
        Text(AppStrings.tryToChangeSearchParams,
            style:
                AppTypography.small.copyWith(color: AppColors.inactiveBlack)),
      ],
    );
  }
}

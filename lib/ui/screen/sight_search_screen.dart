import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({super.key, required this.filteredPlaces});
  static const routeName = 'sight_search_screen';

  final List<Place> filteredPlaces;

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late TextEditingController? controller;
  bool showHistory = true;
  List<Place>? results;

  late final GlobalKey<SearchBarState> _keySearchBar;

  @override
  void initState() {
    _keySearchBar = GlobalKey<SearchBarState>();
    super.initState();
  }

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
                key: _keySearchBar,
                searchRequest: (str, saveInHistory) =>
                    _findSight(str, saveInHistory: saveInHistory),
                isFocused: true, // автофокус
                isEnabled: true,
                hideHistory:
                    _hideHistory, // Скрываем историю когда начинается ввод запроса
                showHistory:
                    _showHistory, // Показываем историю, пока пользователь ещё ничего не ввёл
              ),
              const SizedBox(
                height: 25,
              ),
              showHistory
                  ? _PreviuousSearchList(
                      thenHistoryItemSelected: (str) {
                        return _reFindSight(str);
                      },
                      clearHistory: _clearHistory,
                    )
                  : _searchBody(results)
            ],
          ),
        ),
      ),
    );
  }

  _hideHistory() => setState(
        () {
          showHistory = false;
        },
      );

  _clearHistory() => setState(
        () {
          history.clear();
        },
      );

  _showHistory() => setState(
        () {
          showHistory = true;
        },
      );
  // Показывает заглушку либо результаты поиска
  Widget _searchBody(List<Place>? resultsList) {
    return (resultsList == null || resultsList.isEmpty)
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
          );
  }

  _findSight(String str, {bool saveInHistory = true}) {
    List<Place> res = widget.filteredPlaces
        .where(
          (element) => element.name.toUpperCase().contains(
                str.toUpperCase().trim(),
              ),
        ) // Поиск без учёта регистра и пробелов
        .toList();

    if (saveInHistory) {
      if (!history.contains(str)) {
        history.insert(0, str); // Добавляем в начало списка
      }
    }
    setState(
      () {
        results = res;
        showHistory = false;
      },
    );
  }

  _reFindSight(String str) {
    _keySearchBar.currentState!
        .fillControllerWithValue(str); // Повторный поиск - тоже поиск )
    List<Place> res = widget.filteredPlaces
        .where(
          (element) => element.name.toUpperCase().contains(
                str.toUpperCase().trim(),
              ),
        ) // Поиск без учёта регистра и пробелов
        .toList();
    history.remove(str);
    history.insert(0, str); // Добавляем в начало списка

    setState(
      () {
        results = res;
        showHistory = false;
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({required this.sight});
  final Place sight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context)
            .pushNamed(SightDetails.routeName, arguments: sight);
      },
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
                        sight.urls[0],
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
                        color: themeInteractor
                            .appTheme.bottomNavBarSelectedItemColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    sight.placeType.toString(),
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
  const _PreviuousSearchList({this.clearHistory, this.thenHistoryItemSelected});
  final VoidCallback? clearHistory;
  final Function(String str)? thenHistoryItemSelected;
  @override
  State<_PreviuousSearchList> createState() => __PreviuousSearchListState();
}

class __PreviuousSearchListState extends State<_PreviuousSearchList> {
  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Container();
    }
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
                    whenSelected: widget.thenHistoryItemSelected,
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
        // Кнопка Очистить историю
        TextButton(
            onPressed: () {
              setState(() {
                widget.clearHistory!();
              });
            },
            child: Text(AppStrings.clearHistore,
                style: AppTypography.simpleText
                    .copyWith(color: themeInteractor.appTheme.filterButtonColor)))
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

// Елемент списка Истории поиска с кнопкой удаления из истории
class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {super.key, required this.text, required this.delete, this.whenSelected});
  final String text;
  final VoidCallback delete;
  final Function(String str)? whenSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => whenSelected!(text)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTypography.formLabel
                  .copyWith(color: AppColors.whiteSecondary2),
            ),
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
      ),
    );
  }
}

List<String> history = ["WarnerBros studio"]; // Моковые данные для истории

// Заглушка Ничего не найдено
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

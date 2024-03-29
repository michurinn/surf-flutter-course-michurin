import 'package:flutter/material.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/domain/place.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/dialogs/sight_details_bottom_sheet.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/domain/error_widget.dart' as error_widget;
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({super.key});
  static const routeName = 'sight_search_screen';

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late TextEditingController? controller;
  bool showHistory = true;
  List<Place> results = [];
  bool showErrorWidget = false;
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
                searchRequest: (str, saveInHistory) async => await _findSight(
                    context, str,
                    saveInHistory: saveInHistory),
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
                      thenHistoryItemSelected: (str) async {
                        return await _reFindSight(context, str);
                      },
                      clearHistory: _clearHistory,
                    )
                  : _searchBody(results, showErrorWidget)
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

  _clearHistory() {
    context.read<SearchInteractor>().history.clear();
    setState(
      () {},
    );
  }

  _showHistory() => setState(
        () {
          showHistory = true;
        },
      );
  // Показывает заглушку либо результаты поиска, или ошибку если прилетел Exception
  Widget _searchBody(List<Place> resultsList, bool showErrorWidget) {
    if (showErrorWidget) {
      return const error_widget.ErrorWidget(color: AppColors.inactiveBlack);
    } else {
      return (resultsList.isEmpty)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 180.0),
              child: _CantFindIt(),
            )
          : Column(
              children: resultsList
                  .expand(
                    (element) => [
                      _ListItem(sight: element),
                    ],
                  )
                  .toList(),
            );
    }
  }

  _findSight(BuildContext context, String name,
      {bool saveInHistory = true}) async {
    await context.read<SearchInteractor>().searchByName(name).then(
      (value) {
        if (saveInHistory) {
          context.read<SearchInteractor>().addToHistory(name);
        }
        setState(
          () {
            results = value;
            showHistory = false;
            showErrorWidget = false;
          },
        );
      },
    ).onError((error, stackTrace) {
      setState(
        () {
          results = [];
          showHistory = false;
          showErrorWidget = true;
        },
      );
    });
  }

  _reFindSight(BuildContext context, String name) async {
    _keySearchBar.currentState!
        .fillControllerWithValue(name); // Повторный поиск - тоже поиск )
    await _findSight(context, name, saveInHistory: true);
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
        showDetailsBottomSheet(context, sight);
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      sight.urls.isNotEmpty
                          ? sight.urls[0]
                          : 'https://www.mdpi.com/humans/humans-02-00017/article_deploy/html/images/humans-02-00017-g002.png',
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
                    ).image,
                    onError: (exception, stackTrace) => Container(
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 105,
                        child: Text(
                          sight.name,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.formLabel.copyWith(
                              color: context
                                  .watch<SettingsInteractor>()
                                  .appTheme
                                  .bottomNavBarSelectedItemColor),
                        ),
                      ),
                    ],
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
    if (context.read<SearchInteractor>().history.isEmpty) {
      return const SizedBox.shrink();
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
          children: context
              .read<SearchInteractor>()
              .history
              .expand(
                (element) => [
                  HistoryItem(
                    whenSelected: widget.thenHistoryItemSelected,
                    text: element,
                    delete: () {
                      context
                          .read<SearchInteractor>()
                          .removeFromHistory(element);
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
          child: Text(
            AppStrings.clearHistore,
            style: AppTypography.simpleText.copyWith(
                color: context
                    .watch<SettingsInteractor>()
                    .appTheme
                    .filterButtonColor),
          ),
        )
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
        Text(
          AppStrings.tryToChangeSearchParams,
          style: AppTypography.small.copyWith(color: AppColors.inactiveBlack),
        ),
      ],
    );
  }
}

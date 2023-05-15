import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/home_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:provider/provider.dart';

//Содержимое PageView онбординга
const childrensOfPageview = [_PageFirst(), _PageSecond(), _PageThird()];

//Екран онбординга
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = 'onboarding_screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late bool skipButtonVisible; // Показывать кнопку Пропустить
  late bool startButtonVisible; // Показывать кнопку На старт
  late PageController pageController;
  late int activePoint;
  @override
  void initState() {
    super.initState();
    skipButtonVisible = true;
    activePoint = 0;
    startButtonVisible = false;
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _AppBar(skipButtonVisible: skipButtonVisible),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: PageView(
              onPageChanged: (value) {
                if (value == childrensOfPageview.length - 1) {
                  setState(() {
                    startButtonVisible = true;
                    skipButtonVisible = false;
                    if (pageController.page == null) {
                      activePoint = 0;
                    } else {
                      activePoint = value;
                    }
                  });
                } else {
                  setState(() {
                    startButtonVisible = false;
                    skipButtonVisible = true;
                    if (pageController.page == null) {
                      activePoint = 0;
                    } else {
                      activePoint = value;
                    }
                  });
                }
              },
              controller: pageController,
              children: childrensOfPageview,
            ),
          ),
          Positioned(
              bottom: 90,
              child: Row(
                children: [
                  _CircleBar(
                    activePoint: activePoint,
                    length: childrensOfPageview.length,
                  ),
                ],
              )),
          Positioned(
            bottom: 10,
            child: _OnStartButton(
              isVisible: startButtonVisible,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleBar extends StatefulWidget {
  const _CircleBar({
    Key? key,
    required this.activePoint,
    required this.length,
  }) : super(key: key);

  final int activePoint;
  final int length;

  @override
  State<_CircleBar> createState() => _CircleBarState();
}

class _CircleBarState extends State<_CircleBar> {
  List<_CirclePoint> circleList = [];

  @override
  Widget build(BuildContext context) {
    List<_CirclePoint> circleList = [
      for (int i = 0; i < widget.length; i++)
        _CirclePoint(isActive: i == widget.activePoint ? true : false)
    ];
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50, maxWidth: 70),
      child: SizedBox(
        width: 70,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 10,
            ),
            ...circleList
                .expand((element) => [
                      element,
                      const SizedBox(
                        width: 10,
                      )
                    ])
                .toList()
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
    required this.skipButtonVisible,
  }) : super(key: key);
  final bool skipButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: [
        Visibility(
          visible: skipButtonVisible,
          child: TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                AppStrings.skip,
                style: AppTypography.simpleText.copyWith(
                    color: context.watch<SettingsInteractor>()
                        .appTheme
                        .routeButtonColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Кнопка На старт
class _OnStartButton extends StatelessWidget {
  const _OnStartButton({
    Key? key,
    required this.isVisible,
  }) : super(key: key);
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: OutlinedButton(
        onPressed: () => Navigator.of(context)
            .pushReplacementNamed(SightListScreen.routeName),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          side: const BorderSide(width: 0.0, color: Colors.transparent),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          backgroundColor: context.watch<SettingsInteractor>()
              .appTheme
              .routeButtonColor,
          alignment: Alignment.center,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9, minHeight: 45),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.onStart.toUpperCase(),
                  style: AppTypography.button.copyWith(
                      color: context.watch<SettingsInteractor>()
                          .appTheme
                          .addFormActiveLabel),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Первая страница онбординга
class _PageFirst extends StatelessWidget {
  const _PageFirst();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              AppAssets.onboardingRouter,
              color: context.watch<SettingsInteractor>().appTheme.appTitle,
            ),
            const SizedBox(
              height: 42,
            ),
            Text(
              OnboardingTexts.screen1.title,
              style: AppTypography.title.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .appTitle),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              OnboardingTexts.screen1.subTitle,
              style: AppTypography.small.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .onboardingSubtitle),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}

// Вторая страница онбординга
class _PageSecond extends StatelessWidget {
  const _PageSecond();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              AppAssets.onboardingBackPack,
              color: context.watch<SettingsInteractor>().appTheme.appTitle,
            ),
            const SizedBox(
              height: 42,
            ),
            Text(
              OnboardingTexts.screen2.title,
              style: AppTypography.title.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .appTitle),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              OnboardingTexts.screen2.subTitle,
              style: AppTypography.small.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .onboardingSubtitle),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}

// Третья страница онбординга
class _PageThird extends StatelessWidget {
  const _PageThird();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              AppAssets.onboardingFinger,
              color: context.watch<SettingsInteractor>().appTheme.appTitle,
            ),
            const SizedBox(
              height: 42,
            ),
            Text(
              OnboardingTexts.screen3.title,
              style: AppTypography.title.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .appTitle),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              OnboardingTexts.screen3.subTitle,
              style: AppTypography.small.copyWith(
                  color: context.watch<SettingsInteractor>()
                      .appTheme
                      .onboardingSubtitle),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}

// Кружок индикации текущей страницы
class _CirclePoint extends StatelessWidget {
  const _CirclePoint({required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isActive
              ? context.watch<SettingsInteractor>()
                  .appTheme
                  .routeButtonColor
              : AppColors.inactiveBlack,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

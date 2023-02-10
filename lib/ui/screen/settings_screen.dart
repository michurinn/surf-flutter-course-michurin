import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/main.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

// Екран настроек
class _SettingScreenState extends State<SettingScreen> {
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.settings, style: AppTypography.subtitle),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.darkTheme,
                  style: AppTypography.simpleText,
                ),
                Switch.adaptive(
                  value: _switch,
                  onChanged: (value) {
                    setState(
                      () {
                        _switch = value;
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                    );
                  },
                  activeColor: themeProvider.appTheme.clearButtonColor,
                )
              ],
            ),
            const Divider(
              thickness: 2,
              color: AppColors.inactiveBlack,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.showTutorial,
                    style: AppTypography.simpleText,
                  ),
                  SvgPicture.asset(
                    'assets/icons/info_icon.svg',
                    color: themeProvider.appTheme.clearButtonColor,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              color: AppColors.inactiveBlack,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
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
            label: AppStrings.bottomLabel1,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            activeIcon: SvgPicture.asset(
              AppAssets.mapFilled,
              color: themeProvider.appTheme.bottomNavBarSelectedItemColor,
            ),
            label: AppStrings.bottomLabel2,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.like,
              color: themeProvider.appTheme.bottomNavBarUnselectedItemColor,
            ),
            label: AppStrings.bottomLabel3,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: AppStrings.bottomLabel4,
          ),
        ],
      ),
    );
  }
}

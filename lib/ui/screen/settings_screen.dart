import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  static const routeName = 'settings_screen';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

// Екран настроек
class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final themeProvider = context.watch<SettingsInteractor>().appTheme;
    bool _switch = !context.watch<SettingsInteractor>().isLight;
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
                    context.read<SettingsInteractor>().swipeTheme();
                    setState(
                      () {
                        _switch = value;
                      },
                    );
                  },
                  activeColor: themeProvider.clearButtonColor,
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
                    color: themeProvider.clearButtonColor,
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
    );
  }
}

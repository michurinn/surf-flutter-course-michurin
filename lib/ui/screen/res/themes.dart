import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';

final darkTheme = ThemeData(
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    unselectedLabelColor: AppColors.white,
    unselectedLabelStyle: AppTypography.smallBoldwhite,
    labelStyle: AppTypography.smallBoldwhite,
    labelColor: AppColors.whiteSecondary,
  ),
  dividerColor: AppColors.white,
  primaryColor: AppColors.white,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.backgroundDarkCardColor,
      color: AppColors.whiteSecondary2),
  cardColor: AppColors.backgroundDarkCardColor,
  backgroundColor: AppColors.backgroundDark,
  appBarTheme: AppBarTheme(
    titleTextStyle: AppTypography.largeTitle.copyWith(color: AppColors.white),
    backgroundColor: AppColors.backgroundDark,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundDark,
    unselectedItemColor: AppColors.white,
    unselectedIconTheme: IconThemeData(color: AppColors.white),
    selectedIconTheme: IconThemeData(color: AppColors.white),
  ),
);

final lightTheme = ThemeData(
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      color: AppColors.whiteSecondary,
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    unselectedLabelColor: AppColors.whiteSecondary2,
    unselectedLabelStyle: AppTypography.smallBoldwhite,
    labelStyle: AppTypography.smallBoldwhite,
    labelColor: AppColors.white,
  ),
  dividerColor: AppColors.whiteSecondary,
  primaryColor: AppColors.whiteSecondary,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.backgroundDarkCardColor,
      color: AppColors.whiteSecondary2),
  cardColor: AppColors.cardBackground,
  backgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle:
        AppTypography.largeTitle.copyWith(color: AppColors.whiteSecondary),
    backgroundColor: AppColors.white,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    unselectedItemColor: AppColors.whiteSecondary,
    selectedItemColor: AppColors.whiteSecondary,
    unselectedIconTheme: IconThemeData(color: AppColors.whiteSecondary),
    selectedIconTheme: IconThemeData(color: AppColors.whiteSecondary),
  ),
);

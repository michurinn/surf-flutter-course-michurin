import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_typography.dart';

final darkTheme = ThemeData(
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  ),
  tabBarTheme: const TabBarTheme(
    indicator: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(40.0),
      ),
    ),
    unselectedLabelColor: AppColors.whiteSecondary,
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
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith((states) => Colors.transparent),
  ),
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
  dividerColor: AppColors.inactiveBlack,
  primaryColor: AppColors.whiteSecondary,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      circularTrackColor: AppColors.backgroundDarkCardColor,
      color: AppColors.whiteSecondary2),
  cardColor: AppColors.cardBackground,
  backgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle:
        AppTypography.subtitle.copyWith(color: AppColors.whiteSecondary),
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

abstract class BaseTheme {
  static const cardBackground = Color(0xFFF5F5F5);
  static const green = Color(0xFF4CAF50);
  static const yellow = Color(0xFFFCDD3D);
  static const red = Color(0xFFEF4343);
  static const main = Color(0xFF252849);
  static const secondary = Color(0xFF3B3E5B);
  static const secondary2 = Color(0xFF7C7E92);
  static const inactiveBlack = Color.fromRGBO(124, 126, 146, 0.56);
  static const white = Color(0xFFFFFFFF);

  Color get bottomNavBarSelectedItemColor {
    return secondary;
  }

  Color get bottomNavBarUnselectedItemColor {
    return secondary;
  }

  Color get iconColor {
    return white;
  }

  Color get cardColor {
    return cardBackground;
  }

  Color get cardIconColor {
    return secondary;
  }

  Color get routeButtonColor {
    return green;
  }

  Color get clearButtonColor {
    return green;
  }

  Color get filterButtonColor {
    return green;
  }

  Color get mainColor {
    return main;
  }

  Color get backgroundColor {
    return white;
  }

  Color get badgeColor {
    return main;
  }

  List<Color> get badgeColors {
    return [main, white];
  }

  Color get appTitle {
    return main;
  }

  Color get appLeading {
    return secondary2;
  }

  Color get addFormActiveLabel {
    return white;
  }

  Color get addFormInactiveLabel {
    return inactiveBlack;
  }

  Color get addFormBorder {
    return green.withOpacity(0.4);
  }

  Color get cursorColor {
    return main;
  }

  List<Color> get newPlaceButton {
    return [yellow, green];
  }
}

class LightTheme extends BaseTheme {}

class DarkTheme extends BaseTheme {
  static const background = Color(0xFF2e2e2e);
  static const green = Color(0xFF6ADA6F);
  static const yellow = Color(0xFFFFE769);
  static const red = Color(0xFFCF2A2A);
  static const main = Color(0xFF21222C);
  static const secondary = Color(0xFF3B3E5B);
  static const secondary2 = Color(0xFF7C7E92);
  static const inactiveBlack = Color.fromRGBO(124, 126, 146, 0.56);
  static const white = Color(0xFFFFFFFF);
  static const dark = Color(0xFF1A1A20);
  static const scaffoldBackgroundColor  = Color(0xFF2D2E3E);
  
  
  @override
  Color get bottomNavBarSelectedItemColor {
    return white;
  }

  @override
  Color get bottomNavBarUnselectedItemColor {
    return white;
  }

  @override
  Color get iconColor {
    return white;
  }

  @override
  Color get cardColor {
    return dark;
  }

  @override
  Color get cardIconColor {
    return white;
  }

  @override
  Color get routeButtonColor {
    return green;
  }

  @override
  Color get clearButtonColor {
    return green;
  }

  @override
  Color get mainColor {
    return main;
  }

  @override
  Color get backgroundColor {
    return scaffoldBackgroundColor;
  }

  @override
  List<Color> get badgeColors {
    return [white, main];
  }

  @override
  Color get appTitle {
    return white;
  }

  @override
  Color get cursorColor {
    return white;
  }
}

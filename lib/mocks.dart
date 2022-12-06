import 'package:places/domain/sight.dart';
import 'package:places/res/AppStrings.dart';

//Заглушки с местами
final List mocks = [
  const Sight(AppStrings.sight0name, 59.87717719312971, 29.908010865005355,
      AppStrings.sight0subscr, AppStrings.sightType0, 'assets/olgin.jpg',AppStrings.sight1workTime),
  const Sight(AppStrings.sight1name, 59.974382117593564, 29.716890776684536,
      AppStrings.sight1subscr, AppStrings.sightType1, 'assets/fort.jpg',AppStrings.sight2workTime),
  const Sight(
      AppStrings.sight2name,
      60.71573297869801,
      28.729246819869616,
      AppStrings.sight2subscr,
      AppStrings.sightType1,
      'assets/vyborgskiy-zamok.jpg',AppStrings.sight3workTime),
];

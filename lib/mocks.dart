import 'package:places/domain/sight.dart';
import 'package:places/res/app_strings.dart';

//Заглушки с местами
final List mocks = [
  const Sight(
    name: 'Ольгин пруд',
    lat: 59.87717719312971,
    lon: 29.908010865005355,
    details: AppStrings.sight0subscr,
    type: AppStrings.sightType0,
    imagePath: 'http://s2.fotokto.ru/photo/full/219/2198428.jpg',
    workTime: AppStrings.sight1workTime,
  ),
  const Sight(
    name: 'Форт Константин',
    lat: 59.974382117593564,
    lon: 29.716890776684536,
    details: AppStrings.sight1subscr,
    type: AppStrings.sightType1,
    imagePath: 'http://www.pitert.ru/sites/default/files/04F_NAI6bTU.jpg',
    workTime: AppStrings.sight2workTime,
  ),
  const Sight(
    name: 'Выборгский замок',
    lat: 60.71573297869801,
    lon: 28.729246819869616,
    details: AppStrings.sight2subscr,
    type: AppStrings.sightType1,
    imagePath:
        'https://static.tildacdn.com/tild3063-6337-4662-b536-613839663736/DpDvgAlfgdsfsW0AAE5-.jpg',
    workTime: AppStrings.sight3workTime,
  )
];

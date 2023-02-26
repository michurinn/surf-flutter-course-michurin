import 'package:places/domain/sight.dart';
import 'package:places/res/app_strings.dart';

//Заглушки с местами
List<Sight> mocks = [
  const Sight(
    name: 'Ольгин пруд',
    lat: 59.97717719312971,
    lon: 29.808010865005355,
    details: AppStrings.sight0subscr,
    type: AppStrings.sightType2,
    imagePath: 'http://s2.fotokto.ru/photo/full/219/2198428.jpg',
    workTime: AppStrings.sight1workTime,
  ),
  const Sight(
    name: 'Форт Константин',
    lat: 59.974382117593564,
    lon: 29.716890776684536,
    details: AppStrings.sight1subscr,
    type: AppStrings.sightType3,
    imagePath: 'http://www.pitert.ru/sites/default/files/04F_NAI6bTU.jpg',
    workTime: AppStrings.sight2workTime,
  ),
  const Sight(
    name: 'Выборгский замок',
    lat: 60.01573297869801,
    lon: 29.729246819869616,
    details: AppStrings.sight2subscr,
    type: AppStrings.sightType4,
    imagePath:
        'https://static.tildacdn.com/tild3063-6337-4662-b536-613839663736/DpDvgAlfgdsfsW0AAE5-.jpg',
    workTime: AppStrings.sight3workTime,
  )
];

// Моковые координаты пользователя
Map<String, double> mockCoordinates = {
  'lat': 60.01573297869801,
  'lon': 29.729246819869616,
};

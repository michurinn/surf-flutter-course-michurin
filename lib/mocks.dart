import 'package:places/data/model/place.dart';
import 'package:places/res/app_strings.dart';

//Заглушки с местами
List<Place> mocks = [
  const Place(
    id: 1,
    name: 'Ольгин прудЪ',
    lat: 59.97717719312971,
    lng: 29.808010865005355,
    description: AppStrings.sight0subscr,
    placeType: 'cafe',
    urls: ['http://s2.fotokto.ru/photo/full/219/2198428.jpg'],
  ),
  const Place(
    id: 0,
    name: 'Форт Константин',
    lat: 59.974382117593564,
    lng: 29.716890776684536,
    description: AppStrings.sight1subscr,
    placeType: 'temple',
    urls: ['http://www.pitert.ru/sites/default/files/04F_NAI6bTU.jpg'],
  ),
  const Place(
    id: 2,
    name: 'Выборгский замок',
    lat: 60.01573297869801,
    lng: 29.729246819869616,
    description: AppStrings.sight2subscr,
    placeType: 'theatre',
    urls: [
      'https://static.tildacdn.com/tild3063-6337-4662-b536-613839663736/DpDvgAlfgdsfsW0AAE5-.jpg'
    ],
  ),
];

// Моковые координаты пользователя
Map<String, double> mockCoordinates = {
  'lat': 60.01573297869801,
  'lon': 29.729246819869616,
};

//Заглушки с картинками
List<String> get mocksImages => mocks.map((e) => e.urls.toString()).toList();

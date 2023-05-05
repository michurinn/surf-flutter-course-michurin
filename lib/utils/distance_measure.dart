import 'dart:math';

import 'package:places/domain/place.dart';

// Измерить дистанцию от точки до точки
double getDistanceBetweenCoordinates(checkPoint, centerPoint) {
  var ky = 40000 / 360;
  var kx = cos(pi * centerPoint['lat'] / 180.0) * ky;
  var dx = (centerPoint['lon'] - checkPoint['lon']).abs() * kx;
  var dy = (centerPoint['lat'] - checkPoint['lat']).abs() * ky;
  return sqrt(dx * dx + dy * dy);
}

// Получить координаты для getDistanceBetweenCoordinates
Map<String, double> getCoordinatesFromPlace(final Place place) {
  return {'lon': place.lng, 'lat': place.lat};
}

// Сортировка по расстоянию от cneter
int compareDistanses(Place a, Place b, Map<String, double> center) {
  return (getDistanceBetweenCoordinates(getCoordinatesFromPlace(a), center) -
          getDistanceBetweenCoordinates(getCoordinatesFromPlace(b), center))
      .toInt();
}

// Истина, если place на расстоянии от center не большем, чем radius
bool checkIsInsideRadius(
    Place place, Map<String, double> center, final double radius) {
  return getDistanceBetweenCoordinates(getCoordinatesFromPlace(place), center) <
      radius;
}

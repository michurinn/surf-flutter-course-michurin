import 'dart:math';

// Класс singleton, который хранит текущие настройки фильтра

class Filter {
  static final Filter _instance = Filter._internal();

  factory Filter() {
    return _instance;
  }

  Filter._internal();

  // Изменение списка активных фильтров
  void addOrRemoveFilter(String filterName) {
    if (avaibleTypes.contains(filterName)) {
      avaibleTypes.remove(filterName);
    } else {
      avaibleTypes.add(filterName);
    }
  }

  // Меняется при изменении слайдера
  void setDistanses(double start, double end) {
    distanceFrom = start;
    distanceTo = end;
  }

  // Сброс всех фильтров
  void resetInitualSettings() {
    avaibleTypes = [];
    distanceFrom = 2000;
    distanceTo = 9000;
  }

  // Для хранения активных фильтров
  List<String> avaibleTypes = [];
  // Начальная/конечная радиусы поиска
  double distanceFrom = 2000;
  double distanceTo = 9000;

  // Проверка , входит ли место CheckPoint в Тороид с радиусами distanceFrom, distanceTo
  bool arePointInRange(checkPoint, centerPoint, distanceFrom, distanceTo) {
    var ky = 40000 / 360;
    var kx = cos(pi * centerPoint['lat'] / 180.0) * ky;
    var dx = (centerPoint['lon'] - checkPoint.lon).abs() * kx;
    var dy = (centerPoint['lat'] - checkPoint.lat).abs() * ky;
    return (sqrt(dx * dx + dy * dy) <= distanceTo &&
        sqrt(dx * dx + dy * dy) >= distanceFrom);
  }
}

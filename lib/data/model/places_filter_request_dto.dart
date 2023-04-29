// Класс фильтра, передаётся на сервер для получения списка мест, подходящих под фильтр
class PlacesFilterRequestDto {
  final double? lat; //Широта
  final double? lng; // Долгота
  final double? radius;
  final List<String>? typeFilter; //Фильтр по ипу места
  final String? nameFilter; // Фильтр по наименованию места
  PlacesFilterRequestDto(
      {this.radius, this.typeFilter, this.nameFilter, this.lat, this.lng})
      //  параметры "lat", "lat" и "radius" зависят друг от друга, поэтому если указан один из них, то остальные два становятся обязательными
      : assert((lat == null && lng == null && radius == null) ||
            (lat != null && lng != null && radius != null));

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter
    };
  }
}

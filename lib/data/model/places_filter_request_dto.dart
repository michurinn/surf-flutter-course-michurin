// Класс фильтра, передаётся на сервер для получения списка мест, подходящих под фильтр
import 'package:equatable/equatable.dart';

class PlacesFilterRequestDto extends Equatable {
  final double? lat; //Широта
  final double? lng; // Долгота
  final double? radius;
  final List<String>? typeFilter; //Фильтр по ипу места
  final String? nameFilter; // Фильтр по наименованию места
  const PlacesFilterRequestDto(
      {this.radius, this.typeFilter, this.nameFilter, this.lat, this.lng})
      //  параметры "lat", "lat" и "radius" зависят друг от друга, поэтому если указан один из них, то остальные два становятся обязательными
      : assert((lat == null && lng == null && radius == null) ||
            (lat != null && lng != null && radius != null));

  PlacesFilterRequestDto copyWith({
    double? radius,
    List<String>? typeFilter,
    String? nameFilter,
    double? lat,
    double? lng,
  }) {
    return PlacesFilterRequestDto(
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        nameFilter: nameFilter ?? this.nameFilter,
        radius: radius ?? this.radius,
        typeFilter: typeFilter ?? this.typeFilter);
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'radius': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter
    };
  }

  @override
  String toString() {
    return "$nameFilter $typeFilter $nameFilter $radius $lng $lat";
  }

  @override
  List<Object?> get props => [lat, lng, radius, typeFilter, nameFilter];
}

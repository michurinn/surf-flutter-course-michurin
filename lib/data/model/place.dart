import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_dto.dart';

// Класс места, содержит информацию об интересном месте

class Place extends Equatable {
  final String name;
  final int id;
  final double lat; //Широта
  final double lng; // Долгота
  final String description;
  final String placeType;
  final List<dynamic> urls;

  const Place({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.description,
    required this.placeType,
    required this.urls,
  });

  factory Place.fromPlaceDTO(PlaceDto placeDto) {
    return Place(
        description: placeDto.description,
        id: placeDto.id,
        lat: placeDto.lat,
        lng: placeDto.lng,
        name: placeDto.name,
        placeType: placeDto.placeType,
        urls: placeDto.urls);
  }
  factory Place.fromMap(Map<dynamic, dynamic> map) {
    return Place(
        id: map['id'],
        name: map['name'],
        lat: map['lat'],
        lng: map['lng'],
        description: map['description'],
        placeType: map['placeType'],
        urls: map['urls'] ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'lat': lat,
      'lng': lng,
      'description': description,
      'placeType': placeType,
      'urls': urls
    };
  }

  @override
  List<Object> get props => [name, lat, lng, description, placeType, id, urls];
}

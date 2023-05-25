import 'package:places/domain/place.dart';
//Запланированное для посещения место
class PlacePlanned extends Place {
  final DateTime plannedDate;

  const PlacePlanned(
      {required this.plannedDate,
      required super.id,
      required super.name,
      required super.lat,
      required super.lng,
      required super.description,
      required super.placeType,
      required super.urls});
}

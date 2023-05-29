import 'package:places/domain/place.dart';

// Посещённые места
class PlaceVisited extends Place {
  final DateTime visitedDate;

  const PlaceVisited(
      {required this.visitedDate,
      required super.id,
      required super.name,
      required super.lat,
      required super.lng,
      required super.description,
      required super.placeType,
      required super.urls});
}

// Репозиторий избранных мест
import 'package:places/domain/place.dart';
import 'package:places/domain/place_planned.dart';
import 'package:places/domain/place_visited.dart';

abstract class IVisitedRepository
{
  /// отметить для посещения в будущем
  Future<void> markVisited(PlaceVisited place);
  /// Убрать из избранных
  Future<void> unmarkVisited(PlaceVisited place);
  /// Список посещённых мест
  Future<List<PlaceVisited>> getVisitedPlaces();
}
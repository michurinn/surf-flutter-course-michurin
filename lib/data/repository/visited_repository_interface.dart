// Репозиторий избранных мест
import 'package:places/domain/place_visited.dart';

abstract class IVisitedRepository {
  /// отметить для посещения в будущем
  Future<void> markVisited(PlaceVisited place);

  /// Убрать из избранных
  Future<void> unmarkVisited(PlaceVisited place);

  /// Список посещённых мест
  Future<List<PlaceVisited>> getVisitedPlaces();

  /// Поменять местами draggedPlace & targetPlace
  Future<void> swipe(
      {required int draggedPlaceId, required int targetPlaceId});
}

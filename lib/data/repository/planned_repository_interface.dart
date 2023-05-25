// Репозиторий избранных мест
import 'package:places/domain/place.dart';

abstract class IPlannedRepository {
  /// отметить для посещения в будущем
  Future<void> markFavorite(Place place);

  /// Убрать из избранных
  Future<void> unmarkFavorite(Place place);

  /// Получить списко избранных мест
  Future<List<Place>> getFavoritePlacesSortedByDistance();

  /// Поменять местами draggedPlace & targetPlace
  Future<void> swipe({required int draggedPlaceId, required int targetPlaceId});

  /// Проверить есть ли место в Запланированных
  Future<bool> isPlanned({required int placeId});
}

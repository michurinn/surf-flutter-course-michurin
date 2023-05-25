// Репозиторий избранных мест
import 'package:places/domain/place.dart';
import 'package:places/domain/place_planned.dart';

abstract class IFavoriteRepository
{
  /// отметить для посещения в будущем
  Future<void> markFavorite(PlacePlanned place);
  /// Убрать из избранных
  Future<void> unmarkFavorite(PlacePlanned place);
  /// Получить списко избранных мест
  Future<List<PlacePlanned>> getFavoritePlacesSortedByDistance();
}
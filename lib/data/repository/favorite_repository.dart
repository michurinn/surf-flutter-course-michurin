import 'package:places/data/repository/favorite_repository_interface.dart';
import 'package:places/domain/place_planned.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_measure.dart';

/// Репозиторий избранных мест
class FavoriteRepository implements IFavoriteRepository {
  //Todo(me): РЕализовать хранение в БД, а не в интеракторе

  FavoriteRepository();

  /// отметить для посещения в будущем
  @override
  Future<void> markFavorite(PlacePlanned place) async {
    _favoritePlaces.add(place);
  }

  /// Убрать из избранных
  @override
  Future<void> unmarkFavorite(PlacePlanned place) async {
    _favoritePlaces.remove(place);
  }

  /// Получить списко избранных мест
  @override
  Future<List<PlacePlanned>> getFavoritePlacesSortedByDistance() {
    final result = _favoritePlaces;
    result.sort((a, b) => compareDistanses(a, b, mockCoordinates));
    return Future.value(result);
  }

  ///Список избранных мест
  List<PlacePlanned> get favoritePlaces => _favoritePlaces;

  // TODO(me): Списки должны храниться в БД
  final List<PlacePlanned> _favoritePlaces = [];
}

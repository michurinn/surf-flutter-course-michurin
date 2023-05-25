import 'package:places/data/repository/planned_repository_interface.dart';
import 'package:places/domain/place.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_measure.dart';

/// Репозиторий избранных мест
class FavoriteRepository implements IPlannedRepository {
  //Todo(me): РЕализовать хранение в БД, а не в интеракторе

  FavoriteRepository();

  /// отметить для посещения в будущем
  @override
  Future<void> markFavorite(Place place) async {
    _favoritePlaces.add(place);
  }

  /// Убрать из избранных
  @override
  Future<void> unmarkFavorite(Place place) async {
    _favoritePlaces.remove(place);
  }

  /// Получить списко избранных мест
  @override
  Future<List<Place>> getFavoritePlacesSortedByDistance() {
    final result = _favoritePlaces;
    result.sort((a, b) => compareDistanses(a, b, mockCoordinates));
    return Future.value(result);
  }

  ///Список избранных мест
  List<Place> get favoritePlaces => _favoritePlaces;

  // TODO(me): Списки должны храниться в БД
  final List<Place> _favoritePlaces = [];

  /// Поменять местами draggedPlace & targetPlace
  @override
  Future<void> swipe(
      {required int draggedPlaceId, required int targetPlaceId}) async {
    _favoritePlaces.insert(
      _favoritePlaces.indexWhere((element) => element.id == targetPlaceId),
      _favoritePlaces.removeAt(
        _favoritePlaces.indexWhere((element) => element.id == draggedPlaceId),
      ),
    );
  }

  /// Проверить есть ли место в Запланированных
  @override
  Future<bool> isPlanned({required int placeId}) async {
    return _favoritePlaces.indexWhere((element) => element.id == placeId) == -1
        ? false
        : true;
  }
}

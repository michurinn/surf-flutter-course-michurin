import 'package:places/data/repository/visited_repository_interface.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/place_planned.dart';
import 'package:places/domain/place_visited.dart';

/// Репозиторий посещённых мест
class VisitedRepository implements IVisitedRepository {
  VisitedRepository();

  /// отметить для посещения в будущем
  @override
  Future<void> markVisited(PlaceVisited place) async  {
    _visitedPlaces.add(place);
  }

  /// Убрать из избранных
  @override
  Future<void> unmarkVisited(PlaceVisited place) async {
    _visitedPlaces.remove(place);
  }

  /// TODO(me) Данные должны храниться в БД
  final List<PlaceVisited> _visitedPlaces = [];
  
  @override
  Future<List<PlaceVisited>> getVisitedPlaces() async {
    return Future.value(_visitedPlaces);
  }
}

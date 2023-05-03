import 'package:places/domain/place.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_measure.dart';

class PlaceInteractor {
  static final PlaceInteractor _instance = PlaceInteractor._internal();

  // ignore: non_constant_identifier_names
  factory PlaceInteractor(IPlaceRepository IplaceRepository) {
    placeRepository = IplaceRepository;
    return _instance;
  }

  PlaceInteractor._internal();

  static late final IPlaceRepository placeRepository;

  Future<void> addNewPlace(final Place place) async {
    await placeRepository.addPlace(place);
  }

  void addToVisitingPlaces(final Place place) {
    _visitedPlaces.add(place);
  }

  List<Place> get visitedPlaces => _visitedPlaces;
  List<Place> get favoritePlaces => _favoritePlaces;
  void addToFavorites(final Place place) {
    _favoritePlaces.add(place);
  }

  bool removeFromFavorites(final Place place) {
    return _favoritePlaces.remove(place);
  }

  // Возвращает деталку места
  Future<String?> getPlaceDetails(final int id) async {
    final Place place = await placeRepository.getPlaceByID(id);
    return place.description;
  }

  //Список избранных мест , отфильтрованный по расстоянию
  List<Place> getFavoritePlacesSortedByDistance() {
    final result = _favoritePlaces;
    result.sort((a, b) => compareDistanses(a, b, mockCoordinates));
    return result;
  }

  //Список мест на расстоянии radius, отфильтрованный по расстоянию
  Future<List<Place>> getPlaces(
      {final double? radius, final String? category}) async {
    final List<Place> response = await placeRepository.getPlacesList();

    response.removeWhere((element) => !checkIsInsideRadius(
        element, mockCoordinates, radius ?? double.infinity));
    response.removeWhere(
        (element) => category == null ? false : element.placeType == category);
    response.sort((a, b) => compareDistanses(a, b, mockCoordinates));
    return response;
  }

  final List<Place> _favoritePlaces = [];
  final List<Place> _visitedPlaces = [];
}

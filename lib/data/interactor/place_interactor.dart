import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository_interface.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_measure.dart';

class PlaceInteractor {
  static final PlaceInteractor _instance = PlaceInteractor._internal();

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
    visitedPlaces.add(place);
  }

  List<Place>? get getVisitPlaces => visitedPlaces;

  void addToFavorites(final Place place) {
    favoritePlaces.add(place);
  }

  bool removeFromFavorites(final Place place) {
    return favoritePlaces.remove(place);
  }

  // Возвращает деталку места
  Future<String?> getPlaceDetails(final int id) async {
    final Place? place = await placeRepository.getPlaceByID(id);
    if (place == null) {
      return '';
    } else {
      return place.description;
    }
  }

  //Список избранных мест , отфильтрованный по расстоянию
  List<Place>? getFavoritePlaces(final double lat, final double lng) {
    final result = favoritePlaces;
    result.sort((a, b) => compareDistanses(a, b, mockCoordinates));
    return result;
  }

  //Список мест на расстоянии radius, отфильтрованный по расстоянию
  Future<List<Place>?> getPlaces(
      {final double? radius, final String? category}) async {
    final List<Place>? response = await placeRepository.getPlacesList();
    
    if (response == null) {
      return null;
    } else {
      response.removeWhere((element) => !checkIsInsideRadius(
          element, mockCoordinates, radius ?? double.infinity));
      response.removeWhere((element) =>
          category == null ? false : element.placeType == category);
      response.sort((a, b) => compareDistanses(a, b, mockCoordinates));
      return response;
    }
  }

  final List<Place> favoritePlaces = [];
  final List<Place> visitedPlaces = [];
}

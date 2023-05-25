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

  ///Добавить новое место
  Future<Place> addNewPlace(final Place place) async {
    final response = await placeRepository.addPlace(place);
    return response;
  }

  /// Возвращает деталку места
  Future<String?> getPlaceDetails(final int id) async {
    final Place place = await placeRepository.getPlaceByID(id);
    return place.description;
  }

  ///Список мест на расстоянии radius, отфильтрованный по расстоянию
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

  
}

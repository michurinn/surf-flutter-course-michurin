import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/places_filter_request_dto.dart';

abstract class IPlaceRepository {
  Future<Place?> addPlace(final Place place);
  Future<List<Place>?> getPlacesList();
  Future<Place?> getPlaceByID(final int id);
  Future<Place?> updatePlaceByID(final Place place);
  Future<void> deletePlaceByID(final int id);
  //   Сохранение файлов в хранилище.
  // В ответ приходит путь к загруженному файлу, относительно текущего домена.
  // Данные передаются в multipart/form-data
  // Допустимые типы файлов: jpg, png, gif, svg.
  // Если загружен один файл, то путь к нему содержится в заголовке "location".
  // Если в запросе было больше одного файла, то ответ в виде списка путей к загруженным файлам в теле ответа.

  Future<String?> uploadFile(final String bytes);
  // Запрос списка интересных мест с фильтром.
  // Фильтр задается в теле запроса, список параметров смотри в PlacesFilterRequestDto.
  // Ответ в виде списка типа PlaceDto.
  // Если в запросе были указаны координаты точки и радиус, то в ответе будет расстояние между точкой и местом.

  Future<List<PlaceDto>?> getFilteredPlaces(final PlacesFilterRequestDto filter);
}

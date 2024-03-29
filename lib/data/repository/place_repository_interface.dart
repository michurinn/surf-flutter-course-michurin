import 'package:places/domain/place.dart';
import 'package:places/data/model/places_filter_request_dto.dart';

abstract class IPlaceRepository {
  //Добавить новое место
  Future<Place> addPlace(final Place place);
  // получить список всех мест
  Future<List<Place>> getPlacesList();
  // Получить описание места  по id
  Future<Place> getPlaceByID(final int id);
  // Обновить описание места  по id
  Future<Place> updatePlaceByID(final Place place);
  // Удалить место с указанным id
  Future<void> deletePlaceByID(final int id);
  //   Сохранение файлов в хранилище.
  // В ответ приходит путь к загруженному файлу, относительно текущего домена.
  // Данные передаются в multipart/form-data
  // Допустимые типы файлов: jpg, png, gif, svg.
  // Если загружен один файл, то путь к нему содержится в заголовке "location".
  // Если в запросе было больше одного файла, то ответ в виде списка путей к загруженным файлам в теле ответа.

  Future<List<String>> uploadFile(final String bytes);
  // Запрос списка интересных мест с фильтром.
  // Фильтр задается в теле запроса, список параметров смотри в PlacesFilterRequestDto.
  // Ответ в виде списка типа PlaceDto.
  // Если в запросе были указаны координаты точки и радиус, то в ответе будет расстояние между точкой и местом.

  Future<List<Place>> getFilteredPlaces(final PlacesFilterRequestDto filter);
}

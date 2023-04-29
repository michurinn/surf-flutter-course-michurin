// Модель данных ответа на запрос фильтра мест.
// От модели данных места Place отличается наличием поля distance,
//  в котором при ответе будет расстояние от запрошенной точки
class PlaceDto {
  final String name;
  final int id;
  final double lat; //Широта
  final double lng; // Долгота
  final double? distance;
  final String description;
  final String placeType;
  final List<String> urls;

  const PlaceDto({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.distance,
    required this.description,
    required this.placeType,
    required this.urls,
  });
}

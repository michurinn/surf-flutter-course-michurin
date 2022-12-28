// Класс места, содержит информацию об интересном месте

class Sight {
  final String name;
  final double lat;
  final double lon;
  final String details;
  final String type;
  final String imagePath;
  final String workTime;

  const Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.details,
    required this.type,
    required this.imagePath,
    required this.workTime,
  });
}

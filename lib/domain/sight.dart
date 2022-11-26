// Класс места, содержит информацию об интересном месте
import 'package:flutter/widgets.dart';

class Sight {
  final String name;
  final double lat;
  final double lon;
  final String details;
  final String type;
  final String imagePath;

  const Sight(
    this.name,
    this.lat,
    this.lon,
    this.details,
    this.type,
    this.imagePath
  );
}

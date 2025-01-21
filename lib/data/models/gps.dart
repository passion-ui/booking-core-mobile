import 'package:booking/domain/domain.dart';

class GPSModel {
  final String title;
  final double latitude;
  final double longitude;
  final num zoom;

  GPSModel({
    required this.title,
    required this.latitude,
    required this.longitude,
    this.zoom = 12,
  });

  GPSEntity toEntity() {
    return GPSEntity(
      title: title,
      latitude: latitude,
      longitude: longitude,
      zoom: zoom,
    );
  }
}

class GPSEntity {
  final String title;
  final double latitude;
  final double longitude;
  final num zoom;

  GPSEntity({
    required this.title,
    required this.latitude,
    required this.longitude,
    this.zoom = 12,
  });
}

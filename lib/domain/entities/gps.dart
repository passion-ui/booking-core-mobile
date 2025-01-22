class GPSEntity {
  final String title;
  final double latitude;
  final double longitude;
  final double zoom;
  final bool editable;

  GPSEntity({
    required this.title,
    required this.latitude,
    required this.longitude,
    this.zoom = 12.0,
    this.editable = false,
  });
}

import 'package:flutter/material.dart';

extension IconFactory on Icons {
  static final Map<String, IconData> _iconMap = {
    'fa fa-building-o': Icons.night_shelter_outlined,
    'icofont-building-alt': Icons.apartment_outlined,
    'icofont-car': Icons.directions_car_filled_outlined,
    'icofont-island-alt': Icons.luggage,
    'icofont-ticket': Icons.local_activity_outlined,
    'icofont-ui-flight': Icons.flight_takeoff_outlined,
    'icofont-ship': Icons.directions_boat_outlined,
    'icofont-email': Icons.mark_email_unread_outlined,
  };

  static IconData get(String name) {
    return _iconMap[name] ?? Icons.error_outline;
  }
}

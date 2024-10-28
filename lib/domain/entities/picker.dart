import 'package:flutter/material.dart';

class PickerEntity {
  final String id;
  final String title;
  final Widget? leading;
  final String? description;
  final dynamic data;

  PickerEntity({
    required this.id,
    required this.title,
    this.description,
    this.leading,
    this.data,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PickerEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// models/lesson.dart
import 'package:flutter/material.dart';

class Lesson {
  final String id;
  final String title;
  final String icon;
  final int colorValue;
  final String description;
  final String codeExample;

  const Lesson({
    required this.id,
    required this.title,
    required this.icon,
    required this.colorValue,
    required this.description,
    required this.codeExample,
  });

  Color get color => Color(colorValue);
}

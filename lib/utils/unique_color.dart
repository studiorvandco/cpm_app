import 'package:flutter/material.dart';

/// Identifies the platform the app is running on.
class UniqueColor {
  int _index = 0;
  final List<Color> _colors = [
    const Color(0xFF2f4f4f),
    const Color(0xFF2e8b57),
    const Color(0xFF800000),
    const Color(0xFF808000),
    const Color(0xFF00008b),
    const Color(0xFFff0000),
    const Color(0xFFffa500),
    const Color(0xFFffff00),
    const Color(0xFF7cfc00),
    const Color(0xFF00fa9a),
    const Color(0xFF4169e1),
    const Color(0xFF00ffff),
    const Color(0xFF00bfff),
    const Color(0xFF0000ff),
    const Color(0xFFda70d6),
    const Color(0xFFd8bfd8),
    const Color(0xFFff00ff),
    const Color(0xFFfa8072),
    const Color(0xFFeee8aa),
    const Color(0xFFff1493),
  ];

  static final UniqueColor _instance = UniqueColor._internal();

  Color get getColor {
    return _colors[_index];
  }

  Color get getTextColor {
    return _colors[_index].computeLuminance() > 0.2 ? Colors.black : Colors.white;
  }

  factory UniqueColor() {
    return _instance;
  }

  UniqueColor._internal();

  void reset() {
    _index = 0;
  }

  void next() {
    _index >= _colors.length ? _index = 0 : _index++;
  }
}

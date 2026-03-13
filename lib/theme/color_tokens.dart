import 'package:flutter/material.dart';

class ColorTokens {
  static const List<PresetColor> presets = [
    PresetColor('Green', Color(0xFF00FF00)),
    PresetColor('Cyan', Color(0xFF00FFFF)),
    PresetColor('Red', Color(0xFFFF0000)),
    PresetColor('Yellow', Color(0xFFFFFF00)),
    PresetColor('Magenta', Color(0xFFFF00FF)),
    PresetColor('Blue', Color(0xFF0000FF)),
    PresetColor('White', Color(0xFFFFFFFF)),
    PresetColor('Orange', Color(0xFFFF8C00)),
  ];
}

class PresetColor {
  final String name;
  final Color color;
  const PresetColor(this.name, this.color);
}

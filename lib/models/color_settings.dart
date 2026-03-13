import 'package:flutter/material.dart';
import 'gradient_mode.dart';

class ColorSettings {
  final Color primaryColor;
  final Color? secondaryColor;
  final GradientMode gradientMode;

  const ColorSettings({
    this.primaryColor = const Color(0xFF00FF00),
    this.secondaryColor,
    this.gradientMode = GradientMode.none,
  });

  ColorSettings copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    GradientMode? gradientMode,
  }) {
    return ColorSettings(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      gradientMode: gradientMode ?? this.gradientMode,
    );
  }
}

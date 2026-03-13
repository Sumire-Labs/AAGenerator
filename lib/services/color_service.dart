import 'dart:ui';

import '../models/color_settings.dart';
import '../models/gradient_mode.dart';

class ColorService {
  static Color getColorAt({
    required ColorSettings settings,
    required int charIndex,
    required int totalChars,
    required int lineIndex,
    required int totalLines,
  }) {
    if (settings.gradientMode == GradientMode.none ||
        settings.secondaryColor == null) {
      return settings.primaryColor;
    }

    double t;
    switch (settings.gradientMode) {
      case GradientMode.horizontal:
        t = totalChars > 1 ? charIndex / (totalChars - 1) : 0;
      case GradientMode.vertical:
        t = totalLines > 1 ? lineIndex / (totalLines - 1) : 0;
      case GradientMode.diagonal:
        final hT = totalChars > 1 ? charIndex / (totalChars - 1) : 0;
        final vT = totalLines > 1 ? lineIndex / (totalLines - 1) : 0;
        t = (hT + vT) / 2;
      case GradientMode.none:
        t = 0;
    }

    return Color.lerp(settings.primaryColor, settings.secondaryColor!, t)!;
  }
}

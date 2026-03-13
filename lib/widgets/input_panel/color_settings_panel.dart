import 'package:flutter/material.dart';
import 'preset_color_chips.dart';
import 'custom_color_picker.dart';
import 'gradient_controls.dart';

class ColorSettingsPanel extends StatelessWidget {
  const ColorSettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PresetColorChips(),
        SizedBox(height: 16),
        CustomColorPicker(),
        SizedBox(height: 16),
        GradientControls(),
      ],
    );
  }
}

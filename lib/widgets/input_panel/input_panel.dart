import 'package:flutter/material.dart';
import '../../widgets/shared/section_card.dart';
import 'text_input_field.dart';
import 'font_selector.dart';
import 'color_settings_panel.dart';
import 'output_format_selector.dart';

class InputPanel extends StatelessWidget {
  const InputPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionCard(
          title: 'テキスト入力',
          child: TextInputField(),
        ),
        SizedBox(height: 12),
        SectionCard(
          title: 'フォント',
          child: FontSelector(),
        ),
        SizedBox(height: 12),
        SectionCard(
          title: 'カラー',
          child: ColorSettingsPanel(),
        ),
        SizedBox(height: 12),
        SectionCard(
          title: '出力形式',
          child: OutputFormatSelector(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ascii_font.dart';
import '../../providers/font_provider.dart';

class FontSelector extends ConsumerWidget {
  const FontSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(fontProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AsciiFont.values.map((font) {
        final isSelected = font == selectedFont;
        return ChoiceChip(
          label: Text(font.displayName),
          selected: isSelected,
          onSelected: (_) {
            ref.read(fontProvider.notifier).state = font;
          },
        );
      }).toList(),
    );
  }
}

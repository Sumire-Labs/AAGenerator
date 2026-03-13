import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../../providers/color_provider.dart';

class CustomColorPicker extends ConsumerWidget {
  const CustomColorPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSettings = ref.watch(colorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'カスタムカラー',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final color = colorSettings.primaryColor;
                final result = await showColorPickerDialog(
                  context,
                  color,
                  title: const Text('色を選択'),
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.wheel: true,
                    ColorPickerType.accent: false,
                    ColorPickerType.primary: false,
                  },
                  actionButtons: const ColorPickerActionButtons(
                    dialogActionButtons: true,
                  ),
                );
                ref.read(colorProvider.notifier).state =
                    colorSettings.copyWith(primaryColor: result);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorSettings.primaryColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '#${colorSettings.primaryColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../../models/gradient_mode.dart';
import '../../providers/color_provider.dart';

class GradientControls extends ConsumerWidget {
  const GradientControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSettings = ref.watch(colorProvider);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('グラデーション', style: theme.textTheme.bodySmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: GradientMode.values.map((mode) {
            return ChoiceChip(
              label: Text(mode.displayName),
              selected: colorSettings.gradientMode == mode,
              onSelected: (_) {
                ref.read(colorProvider.notifier).state =
                    colorSettings.copyWith(gradientMode: mode);
              },
            );
          }).toList(),
        ),
        if (colorSettings.gradientMode != GradientMode.none) ...[
          const SizedBox(height: 12),
          Text('セカンダリカラー', style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final color = colorSettings.secondaryColor ?? Colors.blue;
                  final result = await showColorPickerDialog(
                    context,
                    color,
                    title: const Text('セカンダリカラーを選択'),
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
                      colorSettings.copyWith(secondaryColor: result);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colorSettings.secondaryColor ?? Colors.blue,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '#${(colorSettings.secondaryColor ?? Colors.blue).toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/color_provider.dart';
import '../../theme/color_tokens.dart';

class PresetColorChips extends ConsumerWidget {
  const PresetColorChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSettings = ref.watch(colorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'プリセットカラー',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ColorTokens.presets.map((preset) {
            final isSelected = colorSettings.primaryColor.toARGB32() == preset.color.toARGB32();
            return GestureDetector(
              onTap: () {
                ref.read(colorProvider.notifier).state =
                    colorSettings.copyWith(primaryColor: preset.color);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: preset.color,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 3,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: preset.color.withAlpha(80),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.black, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

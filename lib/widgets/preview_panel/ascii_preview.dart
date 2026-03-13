import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/ascii_output_provider.dart';
import '../../providers/color_provider.dart';
import '../../models/gradient_mode.dart';
import '../../services/color_service.dart';

class AsciiPreview extends ConsumerWidget {
  const AsciiPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asciiLines = ref.watch(asciiOutputProvider);
    final colorSettings = ref.watch(colorProvider);
    final theme = Theme.of(context);

    if (asciiLines.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'テキストを入力するとプレビューが表示されます',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildColoredText(asciiLines, colorSettings),
      ),
    );
  }

  Widget _buildColoredText(List<String> lines, colorSettings) {
    if (colorSettings.gradientMode == GradientMode.none ||
        colorSettings.secondaryColor == null) {
      // Simple single-color rendering
      return Text(
        lines.join('\n'),
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          color: colorSettings.primaryColor,
          height: 1.2,
        ),
      );
    }

    // Gradient rendering with RichText
    final textSpans = <InlineSpan>[];
    for (int lineIdx = 0; lineIdx < lines.length; lineIdx++) {
      if (lineIdx > 0) {
        textSpans.add(const TextSpan(text: '\n'));
      }
      final line = lines[lineIdx];
      for (int charIdx = 0; charIdx < line.length; charIdx++) {
        final color = ColorService.getColorAt(
          settings: colorSettings,
          charIndex: charIdx,
          totalChars: line.length,
          lineIndex: lineIdx,
          totalLines: lines.length,
        );
        textSpans.add(
          TextSpan(
            text: line[charIdx],
            style: TextStyle(color: color),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          height: 1.2,
        ),
        children: textSpans,
      ),
    );
  }
}

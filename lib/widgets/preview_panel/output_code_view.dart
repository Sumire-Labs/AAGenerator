import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/formatted_output_provider.dart';

class OutputCodeView extends ConsumerWidget {
  const OutputCodeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedOutput = ref.watch(formattedOutputProvider);
    final theme = Theme.of(context);

    if (formattedOutput.isEmpty) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          '出力がここに表示されます',
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
        child: SelectableText(
          formattedOutput,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            color: theme.colorScheme.onSurface,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}

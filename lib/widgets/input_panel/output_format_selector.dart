import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/output_format.dart';
import '../../models/code_language.dart';
import '../../providers/output_format_provider.dart';

class OutputFormatSelector extends ConsumerWidget {
  const OutputFormatSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFormat = ref.watch(outputFormatProvider);
    final selectedLanguage = ref.watch(codeLanguageProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: OutputFormat.values.map((format) {
            return ChoiceChip(
              label: Text(format.displayName),
              selected: format == selectedFormat,
              onSelected: (_) {
                ref.read(outputFormatProvider.notifier).state = format;
              },
            );
          }).toList(),
        ),
        if (selectedFormat == OutputFormat.codeSnippet) ...[
          const SizedBox(height: 12),
          Text('言語', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CodeLanguage.values.map((lang) {
              return ChoiceChip(
                label: Text(lang.displayName),
                selected: lang == selectedLanguage,
                onSelected: (_) {
                  ref.read(codeLanguageProvider.notifier).state = lang;
                },
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

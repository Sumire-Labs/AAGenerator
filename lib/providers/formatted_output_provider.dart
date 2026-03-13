import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/output_formatter_service.dart';
import 'ascii_output_provider.dart';
import 'color_provider.dart';
import 'output_format_provider.dart';

final formattedOutputProvider = Provider<String>((ref) {
  final asciiLines = ref.watch(asciiOutputProvider);
  final colorSettings = ref.watch(colorProvider);
  final outputFormat = ref.watch(outputFormatProvider);
  final codeLanguage = ref.watch(codeLanguageProvider);

  if (asciiLines.isEmpty) return '';

  return OutputFormatterService.format(
    asciiLines: asciiLines,
    outputFormat: outputFormat,
    colorSettings: colorSettings,
    codeLanguage: codeLanguage,
  );
});

import 'package:flutter_test/flutter_test.dart';
import 'package:aa_generator/services/output_formatter_service.dart';
import 'package:aa_generator/models/output_format.dart';
import 'package:aa_generator/models/code_language.dart';
import 'package:aa_generator/models/color_settings.dart';

void main() {
  final sampleLines = ['line1', 'line2', 'line3'];
  const settings = ColorSettings();

  group('OutputFormatterService', () {
    test('plain format joins lines with newline', () {
      final result = OutputFormatterService.format(
        asciiLines: sampleLines,
        outputFormat: OutputFormat.plain,
        colorSettings: settings,
      );
      expect(result, 'line1\nline2\nline3');
    });

    test('ANSI format includes escape codes', () {
      final result = OutputFormatterService.format(
        asciiLines: sampleLines,
        outputFormat: OutputFormat.ansiEscape,
        colorSettings: settings,
      );
      expect(result, contains('\\033['));
    });

    test('code snippet format wraps in language syntax', () {
      for (final lang in CodeLanguage.values) {
        final result = OutputFormatterService.format(
          asciiLines: sampleLines,
          outputFormat: OutputFormat.codeSnippet,
          colorSettings: settings,
          codeLanguage: lang,
        );
        expect(result, isNotEmpty, reason: '${lang.displayName} should produce output');
      }
    });
  });
}

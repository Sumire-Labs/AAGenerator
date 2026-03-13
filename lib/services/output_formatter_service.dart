import 'dart:ui';
import '../models/output_format.dart';
import '../models/code_language.dart';
import '../models/color_settings.dart';
import '../models/gradient_mode.dart';
import 'color_service.dart';

class OutputFormatterService {
  static String format({
    required List<String> asciiLines,
    required OutputFormat outputFormat,
    required ColorSettings colorSettings,
    CodeLanguage? codeLanguage,
  }) {
    switch (outputFormat) {
      case OutputFormat.plain:
        return asciiLines.join('\n');
      case OutputFormat.discord:
        return _formatDiscord(asciiLines, colorSettings);
      case OutputFormat.ansiEscape:
        return _formatAnsi(asciiLines, colorSettings);
      case OutputFormat.codeSnippet:
        return _formatCode(
          asciiLines,
          colorSettings,
          codeLanguage ?? CodeLanguage.python,
        );
    }
  }

  static String _formatDiscord(List<String> lines, ColorSettings settings) {
    final plain = lines.join('\n');
    if (settings.gradientMode == GradientMode.none ||
        settings.secondaryColor == null) {
      // Use ```ansi with real ESC codes for single color
      final esc = String.fromCharCode(0x1B);
      final r = (settings.primaryColor.r * 255).round();
      final g = (settings.primaryColor.g * 255).round();
      final b = (settings.primaryColor.b * 255).round();
      final ansi = '$esc[38;2;$r;$g;${b}m';
      final reset = '$esc[0m';
      final colored = lines.map((l) => '$ansi$l$reset').join('\n');
      return '```ansi\n$colored\n```';
    }
    // No color — just wrap in code block
    return '```\n$plain\n```';
  }

  static String _colorToAnsi(Color color) {
    return '\\033[38;2;${(color.r * 255).round()};${(color.g * 255).round()};${(color.b * 255).round()}m';
  }

  static String _formatAnsi(List<String> lines, ColorSettings settings) {
    if (settings.gradientMode == GradientMode.none ||
        settings.secondaryColor == null) {
      final ansiColor = _colorToAnsi(settings.primaryColor);
      const reset = '\\033[0m';
      return lines.map((line) => '$ansiColor$line$reset').join('\n');
    }

    final buf = StringBuffer();
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      for (int j = 0; j < line.length; j++) {
        final color = ColorService.getColorAt(
          settings: settings,
          charIndex: j,
          totalChars: line.length,
          lineIndex: i,
          totalLines: lines.length,
        );
        buf.write('${_colorToAnsi(color)}${line[j]}');
      }
      buf.write('\\033[0m');
      if (i < lines.length - 1) buf.write('\n');
    }
    return buf.toString();
  }

  static String _formatCode(
    List<String> lines,
    ColorSettings settings,
    CodeLanguage lang,
  ) {
    final plainText = lines.join('\n');

    switch (lang) {
      case CodeLanguage.bash:
        final escaped = plainText
            .replaceAll(r'\', r'\\')
            .replaceAll('"', r'\"')
            .replaceAll('\$', r'\$');
        if (settings.gradientMode == GradientMode.none ||
            settings.secondaryColor == null) {
          final ansi = _colorToAnsi(settings.primaryColor);
          return 'echo -e "$ansi${escaped.replaceAll('\n', r'\n')}\\033[0m"';
        }
        return 'cat << \'EOF\'\n$plainText\nEOF';

      case CodeLanguage.powershell:
        final escaped = plainText.replaceAll('"', '`"').replaceAll('\$', '`\$');
        return 'Write-Host @"\n$escaped\n"@';

      case CodeLanguage.python:
        final escaped = plainText.replaceAll(r'\', r'\\').replaceAll('"""', r'\"\"\"');
        return 'print("""\\\n$escaped\n""")';

      case CodeLanguage.javascript:
        final escaped = plainText.replaceAll(r'\', r'\\').replaceAll('`', r'\`').replaceAll('\$', r'\$');
        return 'console.log(`\n$escaped\n`);';
    }
  }
}

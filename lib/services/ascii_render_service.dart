import '../fonts/font_registry.dart';
import '../models/ascii_font.dart';

class AsciiRenderService {
  static List<String> render(String text, AsciiFont font) {
    if (text.isEmpty) return [];

    final glyphMap = FontRegistry.getFont(font);
    final height = FontRegistry.getFontHeight(font);
    if (height == 0) return [];

    final upperText = text.toUpperCase();
    final lines = List.generate(height, (_) => StringBuffer());

    for (int i = 0; i < upperText.length; i++) {
      final char = upperText[i];
      final glyph = glyphMap[char] ?? glyphMap[' '];
      if (glyph == null) continue;

      if (i > 0) {
        for (int row = 0; row < height; row++) {
          lines[row].write(' ');
        }
      }

      for (int row = 0; row < height; row++) {
        if (row < glyph.length) {
          lines[row].write(glyph[row]);
        }
      }
    }

    return lines.map((sb) => sb.toString()).toList();
  }
}

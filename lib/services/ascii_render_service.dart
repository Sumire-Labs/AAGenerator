import '../fonts/font_registry.dart';
import '../models/ascii_font.dart';

class AsciiRenderService {
  static List<String> render(String text, AsciiFont font) {
    if (text.isEmpty) return [];

    final glyphMap = FontRegistry.getFont(font);
    final height = FontRegistry.getFontHeight(font);
    if (height == 0) return [];

    final chars = text.runes.map((r) {
      final c = String.fromCharCode(r);
      if (r >= 0x61 && r <= 0x7A) return c.toUpperCase();
      return c;
    }).toList();
    final lines = List.generate(height, (_) => StringBuffer());

    for (int i = 0; i < chars.length; i++) {
      final char = chars[i];
      final glyph = glyphMap[char] ?? glyphMap[' '];
      if (glyph == null) continue;

      // Add separator between characters (not before first)
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

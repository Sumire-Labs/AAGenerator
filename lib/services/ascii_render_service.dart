import '../fonts/font_registry.dart';
import '../fonts/glyph_definition.dart';
import '../models/ascii_font.dart';

class AsciiRenderService {
  // Blockフォントの日本語グリフをフォールバック用に取得
  static GlyphMap? _japaneseFallback;
  static GlyphMap get _fallback =>
      _japaneseFallback ??= FontRegistry.getFont(AsciiFont.block);

  static List<String> _adjustGlyphHeight(List<String> glyph, int targetHeight) {
    if (glyph.length == targetHeight) return glyph;
    final width = glyph.isNotEmpty ? glyph.first.length : 0;
    final emptyRow = ' ' * width;
    if (glyph.length < targetHeight) {
      // 下に空行を追加
      return [...glyph, ...List.filled(targetHeight - glyph.length, emptyRow)];
    }
    // 多い場合は切り詰め
    return glyph.sublist(0, targetHeight);
  }

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
      var glyph = glyphMap[char];
      // 見つからない場合、Blockフォントの日本語グリフにフォールバック
      if (glyph == null && font != AsciiFont.block) {
        final fallbackGlyph = _fallback[char];
        if (fallbackGlyph != null) {
          glyph = _adjustGlyphHeight(fallbackGlyph, height);
        }
      }
      glyph ??= glyphMap[' '];
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

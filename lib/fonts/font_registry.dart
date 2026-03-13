import 'glyph_definition.dart';
import '../models/ascii_font.dart';
import 'block/block_font.dart';
import 'slim/slim_font.dart';
import 'ansi_shadow/ansi_shadow_font.dart';
import 'doom/doom_font.dart';

class FontRegistry {
  static final Map<AsciiFont, GlyphMap> _cache = {};

  static GlyphMap getFont(AsciiFont font) {
    return _cache.putIfAbsent(font, () => _buildFont(font));
  }

  static GlyphMap _buildFont(AsciiFont font) {
    switch (font) {
      case AsciiFont.block:
        return buildBlockFont();
      case AsciiFont.slim:
        return buildSlimFont();
      case AsciiFont.ansiShadow:
        return buildAnsiShadowFont();
      case AsciiFont.doom:
        return buildDoomFont();
    }
  }

  static int getFontHeight(AsciiFont font) {
    final glyphs = getFont(font);
    if (glyphs.isEmpty) return 0;
    return glyphs.values.first.length;
  }
}

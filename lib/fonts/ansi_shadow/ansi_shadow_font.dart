import '../glyph_definition.dart';
import 'ansi_shadow_letters_a_i.dart';
import 'ansi_shadow_letters_j_r.dart';
import 'ansi_shadow_letters_s_z.dart';
import 'ansi_shadow_digits.dart';
import 'ansi_shadow_symbols.dart';

GlyphMap buildAnsiShadowFont() {
  return {
    ...ansiShadowLettersAI,
    ...ansiShadowLettersJR,
    ...ansiShadowLettersSZ,
    ...ansiShadowDigits,
    ...ansiShadowSymbols,
  };
}

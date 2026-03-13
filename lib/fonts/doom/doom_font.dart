import '../glyph_definition.dart';
import 'doom_letters_a_i.dart';
import 'doom_letters_j_r.dart';
import 'doom_letters_s_z.dart';
import 'doom_digits.dart';
import 'doom_symbols.dart';

GlyphMap buildDoomFont() {
  return {
    ...doomLettersAI,
    ...doomLettersJR,
    ...doomLettersSZ,
    ...doomDigits,
    ...doomSymbols,
  };
}

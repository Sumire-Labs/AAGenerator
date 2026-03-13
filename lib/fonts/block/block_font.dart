import '../glyph_definition.dart';
import 'block_letters.dart';
import 'block_digits.dart';
import 'block_symbols.dart';
GlyphMap buildBlockFont() {
  return {
    ...blockLetters,
    ...blockDigits,
    ...blockSymbols,
  };
}

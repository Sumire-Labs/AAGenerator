import '../glyph_definition.dart';
import 'slim_letters.dart';
import 'slim_digits.dart';
import 'slim_symbols.dart';

GlyphMap buildSlimFont() {
  return {
    ...slimLetters,
    ...slimDigits,
    ...slimSymbols,
  };
}

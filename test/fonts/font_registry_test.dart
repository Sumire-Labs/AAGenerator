import 'package:flutter_test/flutter_test.dart';
import 'package:aa_generator/fonts/font_registry.dart';
import 'package:aa_generator/models/ascii_font.dart';

void main() {
  group('FontRegistry', () {
    test('all fonts have glyphs for A-Z', () {
      for (final font in AsciiFont.values) {
        final glyphMap = FontRegistry.getFont(font);
        for (int i = 0; i < 26; i++) {
          final char = String.fromCharCode(65 + i); // A-Z
          expect(glyphMap.containsKey(char), isTrue,
              reason: '${font.displayName} should have glyph for $char');
        }
      }
    });

    test('all fonts have glyphs for 0-9', () {
      for (final font in AsciiFont.values) {
        final glyphMap = FontRegistry.getFont(font);
        for (int i = 0; i < 10; i++) {
          final char = '$i';
          expect(glyphMap.containsKey(char), isTrue,
              reason: '${font.displayName} should have glyph for $char');
        }
      }
    });

    test('all fonts have space glyph', () {
      for (final font in AsciiFont.values) {
        final glyphMap = FontRegistry.getFont(font);
        expect(glyphMap.containsKey(' '), isTrue,
            reason: '${font.displayName} should have space glyph');
      }
    });

    test('font height is consistent within each font', () {
      for (final font in AsciiFont.values) {
        final glyphMap = FontRegistry.getFont(font);
        final height = FontRegistry.getFontHeight(font);
        for (final entry in glyphMap.entries) {
          expect(entry.value.length, height,
              reason:
                  '${font.displayName} glyph ${entry.key} should have $height lines');
        }
      }
    });
  });
}

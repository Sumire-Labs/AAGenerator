import 'package:flutter_test/flutter_test.dart';
import 'package:aa_generator/services/ascii_render_service.dart';
import 'package:aa_generator/models/ascii_font.dart';

void main() {
  group('AsciiRenderService', () {
    test('renders empty string as empty list', () {
      final result = AsciiRenderService.render('', AsciiFont.block);
      expect(result, isEmpty);
    });

    test('renders single character with Block font', () {
      final result = AsciiRenderService.render('A', AsciiFont.block);
      expect(result, isNotEmpty);
      expect(result.length, 5); // Block font is 5 lines tall
    });

    test('converts lowercase to uppercase', () {
      final lower = AsciiRenderService.render('a', AsciiFont.block);
      final upper = AsciiRenderService.render('A', AsciiFont.block);
      expect(lower, equals(upper));
    });

    test('renders multiple characters', () {
      final result = AsciiRenderService.render('HI', AsciiFont.block);
      expect(result, isNotEmpty);
      expect(result.length, 5);
      // Each line should contain both characters separated by space
      for (final line in result) {
        expect(line.length, greaterThan(7)); // At least wider than one char
      }
    });

    test('renders with all font types', () {
      for (final font in AsciiFont.values) {
        final result = AsciiRenderService.render('A', font);
        expect(result, isNotEmpty, reason: '${font.displayName} should render A');
      }
    });
  });
}

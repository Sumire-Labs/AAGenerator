import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ascii_render_service.dart';
import 'input_provider.dart';
import 'font_provider.dart';

final asciiOutputProvider = Provider<List<String>>((ref) {
  final text = ref.watch(inputProvider);
  final font = ref.watch(fontProvider);
  if (text.isEmpty) return [];
  return AsciiRenderService.render(text, font);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ascii_font.dart';

final fontProvider = StateProvider<AsciiFont>((ref) => AsciiFont.block);

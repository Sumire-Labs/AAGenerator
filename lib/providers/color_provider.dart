import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/color_settings.dart';

final colorProvider = StateProvider<ColorSettings>((ref) => const ColorSettings());

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/output_format.dart';
import '../models/code_language.dart';

final outputFormatProvider = StateProvider<OutputFormat>((ref) => OutputFormat.plain);
final codeLanguageProvider = StateProvider<CodeLanguage>((ref) => CodeLanguage.python);

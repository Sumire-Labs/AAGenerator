import 'package:flutter/services.dart';

class ClipboardService {
  static Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}

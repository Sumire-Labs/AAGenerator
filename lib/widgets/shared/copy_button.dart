import 'package:flutter/material.dart';
import '../../services/clipboard_service.dart';

class CopyButton extends StatelessWidget {
  final String text;
  final String label;

  const CopyButton({
    super.key,
    required this.text,
    this.label = 'コピー',
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: text.isEmpty
          ? null
          : () async {
              await ClipboardService.copy(text);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('クリップボードにコピーしました！'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
      icon: const Icon(Icons.copy, size: 18),
      label: Text(label),
    );
  }
}

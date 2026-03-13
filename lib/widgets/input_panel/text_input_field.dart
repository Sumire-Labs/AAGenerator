import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/input_provider.dart';

class TextInputField extends ConsumerWidget {
  const TextInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        hintText: '変換するテキストを入力...',
        prefixIcon: Icon(Icons.text_fields),
      ),
      onChanged: (value) {
        ref.read(inputProvider.notifier).state = value;
      },
      maxLength: 15,
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/shared/section_card.dart';
import '../../widgets/shared/copy_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ascii_output_provider.dart';
import '../../providers/formatted_output_provider.dart';
import 'ascii_preview.dart';
import 'output_code_view.dart';

class PreviewPanel extends ConsumerWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asciiLines = ref.watch(asciiOutputProvider);
    final formattedOutput = ref.watch(formattedOutputProvider);

    return Column(
      children: [
        SectionCard(
          title: 'プレビュー',
          actions: [
            CopyButton(
              text: asciiLines.join('\n'),
              label: 'ASCIIコピー',
            ),
          ],
          child: const AsciiPreview(),
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: '出力',
          actions: [
            CopyButton(
              text: formattedOutput,
              label: '出力コピー',
            ),
          ],
          child: const OutputCodeView(),
        ),
      ],
    );
  }
}

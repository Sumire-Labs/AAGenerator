import 'package:flutter/material.dart';
import '../widgets/shared/responsive_layout.dart';
import '../widgets/input_panel/input_panel.dart';
import '../widgets/preview_panel/preview_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ASCIIアートジェネレーター'),
        centerTitle: false,
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ResponsiveLayout(
          inputPanel: InputPanel(),
          previewPanel: PreviewPanel(),
        ),
      ),
    );
  }
}

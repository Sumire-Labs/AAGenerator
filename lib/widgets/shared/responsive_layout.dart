import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget inputPanel;
  final Widget previewPanel;

  const ResponsiveLayout({
    super.key,
    required this.inputPanel,
    required this.previewPanel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(child: inputPanel),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: previewPanel,
              ),
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                inputPanel,
                const SizedBox(height: 16),
                previewPanel,
              ],
            ),
          );
        }
      },
    );
  }
}

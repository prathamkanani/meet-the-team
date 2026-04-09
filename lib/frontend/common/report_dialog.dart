import 'package:flutter/material.dart';

class ReportDialog extends StatelessWidget {
  const ReportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);
    final TextTheme th = TextTheme.of(context);

    return AlertDialog(
      backgroundColor: cs.surface,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(30)),
      title: const Text('Report sent'),
      content: Text(
        'Thanks for reporting this issue. Our team will look into it.',
        style: th.bodyMedium?.copyWith(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

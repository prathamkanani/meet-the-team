import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);

    return Center(
      child: CircularProgressIndicator(
        color: cs.onSurface,
        strokeWidth: 2,
      ),
    );
  }
}

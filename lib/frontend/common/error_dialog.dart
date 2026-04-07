import 'package:flutter/material.dart';
import '../../domain/entity/error.dart';
import '../config/app_spacing.dart';
import '../config/app_theme.dart';

class ErrorDialog extends StatelessWidget {
  final AppException exception;

  const ErrorDialog({super.key, required this.exception});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);

    return Dialog(
      child: Column(
        mainAxisSize: .min,
        children: [
          // Image.asset(''),
          const Icon(
            Icons.warning_rounded,
            size: 100,
            color: AppColors.statusWarnOrangeBg,
          ),
          AppSpacing.h08,
          Text(
            exception.message,
            style: textTheme.titleLarge?.copyWith(fontWeight: .w600),
          ),
          AppSpacing.h08,
          TextButton.icon(
            onPressed: () {},
            label: const Text('Show Details'),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconAlignment: .end,
          ),
          AppSpacing.h08,
          FilledButton.icon(
            onPressed: () {},
            label: const Text('Retry'),
            icon: const Icon(Icons.refresh),
          ),
          AppSpacing.h08,
          TextButton.icon(
            onPressed: () {},
            label: const Text('Report'),
            icon: const Icon(Icons.bug_report_outlined),
            iconAlignment: .start,
          ),
        ],
      ),
    );
  }
}

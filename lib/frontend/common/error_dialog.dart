import 'package:flutter/material.dart';
import '../../domain/entity/error.dart';
import '../config/app_spacing.dart';
import '../config/app_theme.dart';
import 'base_container.dart';

class ErrorDialog extends StatefulWidget {
  final AppException exception;

  const ErrorDialog({super.key, required this.exception});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme cs = ColorScheme.of(context);

    return Dialog(
      backgroundColor: cs.surface,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            // Image.asset(''),
            const Icon(Icons.warning_rounded, size: 100),
            AppSpacing.h08,
            Text(
              widget.exception.message,
              style: textTheme.titleLarge?.copyWith(fontWeight: .w600),
            ),
            AppSpacing.h08,
            GestureDetector(
              onTap: () {
                setState(() {
                  _showDetails = !_showDetails;
                });
              },
              child: BaseContainer(
                backgroundColor: cs.secondaryContainer.withValues(alpha: 0.5),
                borderRadius: 30,
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              'TECHNICAL LOGS',
                              style: textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Text(
                              _showDetails ? 'Hide Details' : 'Show Details',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: .w600,
                              ),
                            ),
                            Icon(
                              _showDetails
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _showDetails
                        ? Divider(
                            height: 0,
                            color: cs.primary.withValues(alpha: 0.5),
                          )
                        : const SizedBox.shrink(),
                    _showDetails
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(widget.exception.toString()),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
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
      ),
    );
  }
}

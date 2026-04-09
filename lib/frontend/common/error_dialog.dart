import 'package:flutter/material.dart';
import '../../application/logic/error/error_cubit.dart';
import '../../domain/entity/error.dart';
import '../config/app_spacing.dart';
import '../config/app_theme.dart';
import 'base_container.dart';

class ErrorDialog extends StatefulWidget {
  final AppException exception;
  final ErrorCubit errorCubit;
  final Future<void> Function() retry;

  const ErrorDialog({
    super.key,
    required this.exception,
    required this.errorCubit,
    required this.retry,
  });

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme cs = ColorScheme.of(context);
    final ErrorTheme et = Theme.of(context).extension<ErrorTheme>()!;

    return Dialog(
      backgroundColor: cs.surface,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: .min,
          children: [
            // Image.asset(''),
            Icon(Icons.warning_rounded, size: 100, color: et.secondaryColor),
            AppSpacing.h08,
            Text(
              widget.exception.message,
              textAlign: .center,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: .w600,
                color: et.primaryColor,
              ),
            ),
            AppSpacing.h16,
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
                              style: textTheme.titleMedium?.copyWith(
                                color: et.primaryColor,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              _showDetails ? 'Hide Details' : 'Show Details',
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: .w600,
                                color: et.primaryColor,
                              ),
                            ),
                            Icon(
                              _showDetails
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 16,
                              color: et.primaryColor,
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
                            child: Text(
                              widget.exception.toString(),
                              style: TextStyle(color: et.primaryColor),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            AppSpacing.h16,
            FilledButton.icon(
              onPressed: () => widget.errorCubit.retry(widget.retry),
              label: const Text('Retry'),
              icon: const Icon(Icons.refresh),
              style: et.retryButtonStyle,
            ),
            AppSpacing.h08,
            TextButton.icon(
              onPressed: () => widget.errorCubit.report(widget.exception),
              label: const Text('Report'),
              icon: const Icon(Icons.bug_report_outlined),
              iconAlignment: .start,
              style: et.reportButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}

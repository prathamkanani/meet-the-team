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

    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              widget.exception.message,
              style: textTheme.titleLarge?.copyWith(fontWeight: .w600),
            ),
            AppSpacing.h08,
            BaseContainer(
              backgroundColor: AppColors.aMPMCycleBgColor,
              borderRadius: 30,
              child: Column(
                mainAxisSize: .min,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16),
                      child: Row(
                        children: [
                          const Text(
                            'TECHNICAL LOGS',
                            style: AppTextStyles.cycleLabelInactive,
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _showDetails = !_showDetails;
                              });
                            },
                            label: Text(
                              _showDetails ? 'Hide Details' : 'Show Details',
                            ),
                            icon: Icon(
                              _showDetails
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                            iconAlignment: .end,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _showDetails ? const Divider() : const SizedBox.shrink(),
                  _showDetails
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(widget.exception.toString()),
                        )
                      : const SizedBox.shrink(),
                ],
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

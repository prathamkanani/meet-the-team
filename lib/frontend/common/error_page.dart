import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/logic/error/error_cubit.dart';
import '../../application/logic/error/error_state.dart';
import '../../domain/entity/error.dart';
import '../../infrastructure/app_injector.dart';
import '../config/app_spacing.dart';
import '../config/app_theme.dart';
import 'report_dialog.dart';

class ErrorPage extends StatefulWidget {
  final AppException exception;
  final Future<void> Function() retry;

  const ErrorPage({super.key, required this.exception, required this.retry});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  late final ErrorCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = locator.get()..handle(widget.exception);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: BlocConsumer<ErrorCubit, ErrorState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is ErrorRetryState) {
            Navigator.pop(context);
          } else if (state is ErrorReportedState) {
            _showReportDialog(context);
          }
        },
        builder: (context, state) {
          if (state is ErrorVisibleState) {
            return _ErrorView(
              exception: widget.exception,
              errorEntity: state.error,
              cubit: _cubit,
              retry: widget.retry,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _showReportDialog(BuildContext context) async {
    await showDialog(context: context, builder: (_) => const ReportDialog());
    if (context.mounted) Navigator.pop(context);
  }
}

class _ErrorView extends StatelessWidget {
  final Future<void> Function() retry;
  final ErrorEntity errorEntity;
  final ErrorCubit cubit;
  final AppException exception;

  const _ErrorView({
    required this.exception,
    required this.errorEntity,
    required this.cubit,
    required this.retry,
  });

  @override
  Widget build(BuildContext context) {
    final ErrorTheme et = Theme.of(context).extension<ErrorTheme>()!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: et.primaryColor),
            AppSpacing.h16,
            Text(
              errorEntity.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: et.primaryColor),
            ),
            AppSpacing.h16,
            FilledButton.icon(
              onPressed: () => cubit.retry(retry),
              label: const Text('Retry'),
              icon: const Icon(Icons.refresh),
              style: et.retryButtonStyle,
            ),
            AppSpacing.h08,
            TextButton.icon(
              onPressed: () => cubit.report(exception),
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

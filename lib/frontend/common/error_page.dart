import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/logic/error/error_cubit.dart';
import '../../application/logic/error/error_state.dart';
import '../../domain/entity/error.dart';
import '../../infrastructure/app_injector.dart';
import '../config/app_spacing.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: BlocConsumer<ErrorCubit, ErrorState>(
        bloc: _cubit,
        listener: (_, state) {
          if (state is ErrorReportedState || state is ErrorRetryState) {
            Navigator.pop(context);
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 60),
            AppSpacing.h16,
            Text(
              errorEntity.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            AppSpacing.h16,
            ElevatedButton(
              onPressed: () => cubit.retry(retry),
              child: const Text("Retry"),
            ),
            AppSpacing.h16,
            TextButton(
              onPressed: () => _showDetails(context),
              child: const Text("Show Details"),
            ),
            TextButton(
              onPressed: () => cubit.report(exception),
              child: const Text("Report Issue"),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error Details"),
        content: Text(errorEntity.error.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}

import 'dart:developer';
import '../../domain/entity/error.dart';
import '../../domain/repository/error_repository.dart';

class ErrorRepositoryImpl implements ErrorRepository {
  const ErrorRepositoryImpl();

  @override
  Future<void> reportError(AppException exception) async {
    log(
      exception.message,
      error: exception.error,
      stackTrace: exception.trace,
      name: 'AppError',
    );

    await _log(exception);
  }

  @override
  Future<void> retry(Future<void> Function() retryCallback) async {
    try {
      await retryCallback();
    } catch (e, stack) {
      if (e is AppException) rethrow;

      throw ServerException(
        message: "Retry execution failed",
        error: e,
        trace: stack,
      );
    }
  }

  Future<void> _log(AppException exception) async {
    // delay
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
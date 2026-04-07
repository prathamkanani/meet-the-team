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

    // log in the db
    await _log(exception);
  }

  Future<void> _log(AppException exception) async {
    // delay
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
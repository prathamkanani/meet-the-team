import '../entity/error.dart';

abstract class ErrorRepository {
  Future<void> reportError(AppException exception);
}
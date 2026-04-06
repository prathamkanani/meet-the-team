import '../../../domain/entity/error.dart';

sealed class ErrorState {}

final class ErrorInitialState extends ErrorState {}

final class ErrorVisibleState extends ErrorState {
  final ErrorEntity error;

  ErrorVisibleState(this.error);
}

final class ErrorReportedState extends ErrorState {}

final class ErrorRetryState extends ErrorState {}

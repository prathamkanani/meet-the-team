enum AppExceptionType { network, server, state, argument, unknown }

class ErrorEntity {
  /// The human-readable message.
  final String message;

  /// The underlying error.
  final Object? error;

  /// The stacktrace, if available.
  final StackTrace? trace;

  const ErrorEntity({required this.message, this.error, this.trace});
}

abstract class AppException implements Exception {
  /// The human-readable message.
  final String message;

  /// The underlying error.
  final Object? error;

  /// The stacktrace, if available.
  final StackTrace? trace;

  AppExceptionType get type;

  const AppException({required this.message, this.error, this.trace});
}

final class NetworkException extends AppException {
  const NetworkException({required super.message, super.error, super.trace});

  @override
  AppExceptionType get type => .network;
}

final class ServerException extends AppException {
  const ServerException({required super.message, super.error, super.trace});

  @override
  AppExceptionType get type => .server;
}

final class StateException extends AppException {
  const StateException({required super.message, super.error, super.trace});

  @override
  AppExceptionType get type => .state;
}

final class ArgumentException extends AppException {
  const ArgumentException({required super.message, super.error, super.trace});

  @override
  AppExceptionType get type => .argument;
}

final class UnknownException extends AppException {
  const UnknownException({required super.message, super.error, super.trace});

  @override
  AppExceptionType get type => .unknown;
}

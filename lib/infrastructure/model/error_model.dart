import '../../domain/entity/error.dart';

class ErrorModel extends ErrorEntity {
  const ErrorModel({required super.message, super.error});
}

class ErrorMapper {
  static ErrorModel mapper(AppException e) {
    switch (e.type) {
      case AppExceptionType.network:
        return const ErrorModel(message: "No Internet! Please try again.");

      case AppExceptionType.server:
        return const ErrorModel(
          message: "Server error. Please try again later.",
        );

      case AppExceptionType.state:
        return const ErrorModel(
          message: "Resources cannot be accesses. Please try again later.",
        );

      case AppExceptionType.argument:
        return const ErrorModel(
          message: "Invalid input. Please enter a valid input.",
        );

      case AppExceptionType.unknown:
        return const ErrorModel(
          message: "Something went wrong. Please try again later.",
        );
    }
  }
}

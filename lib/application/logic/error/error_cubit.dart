import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/error.dart';
import '../../../domain/repository/error_repository.dart';
import '../../../domain/repository/user_repository.dart';
import '../../../infrastructure/model/error_model.dart';
import 'error_state.dart';

class ErrorCubit extends Cubit<ErrorState> {
  final ErrorRepository repository;

  ErrorCubit(this.repository) : super(ErrorInitialState());

  Future<void> handle(AppException exception) async {
    final error = ErrorMapper.mapper(exception);

    emit(ErrorVisibleState(error));
  }

  Future<void> retry(Future<void> Function() retryCallback) async {
    await retryCallback();
    emit(ErrorRetryState());
  }

  Future<void> report(AppException exception) async {
    await repository.reportError(exception);
    emit(ErrorReportedState());
  }

  void clear() => emit(ErrorInitialState());
}

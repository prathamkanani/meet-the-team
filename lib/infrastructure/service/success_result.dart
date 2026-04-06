import '../../application/service/result.dart';

class SuccessResult<L, R> extends Result<L, R> {
  final R success;

  SuccessResult(this.success);

  @override
  T fold<T>({
    required T Function(L left) onFailure,
    required T Function(R right) onSuccess,
  }) {
    return onSuccess(success);
  }
}

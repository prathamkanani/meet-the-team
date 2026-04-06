import '../../application/service/result.dart';

class FailureResult<L, R> extends Result<L, R> {
  final L failure;

  FailureResult(this.failure);

  @override
  T fold<T>({
    required T Function(L left) onFailure,
    required T Function(R right) onSuccess,
  }) {
    return onFailure(failure);
  }
}

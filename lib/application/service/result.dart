abstract class Result<L, R> {
  T fold<T>({
    required T Function(L left) onFailure,
    required T Function(R right) onSuccess,
  });
}

import '../../domain/entity/error.dart';
import '../source/user_source.dart';

class MockTaskRepository {
  final MockTaskDataSource dataSource;

  MockTaskRepository(this.dataSource);

  Future<List<String>> fetchTasks() async {
    try {
      return await dataSource.fetchTasks();
    } catch (e, stack) {
      if (e is AppException) rethrow;

      throw ServerException(
        message: "Mock repo failure",
        error: e,
        trace: stack,
      );
    }
  }
}
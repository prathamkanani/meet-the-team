import '../../domain/entity/error.dart';

class MockTaskDataSource {
  int _counter = 0;

  Future<List<String>> fetchTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    _counter++;

    if (_counter < 3) {
      throw NetworkException(
        message: "Mock: No internet (attempt $_counter)",
      );
    }

    return ["Task A", "Task B", "Task C"];
  }
}
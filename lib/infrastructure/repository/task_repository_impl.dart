import '../../domain/entity/error.dart';
import '../../domain/repository/task_repository.dart';
import '../model/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  int _counter = 0;

  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      taskId: '#1024',
      title: 'Server Infrastructure Audit',
      description:
          'Pending security clearance from external vendor regarding the primary data nodes.',
      status: const TaskStatusModel(
        isApproved: true,
        hasWarning: true,
        isBlocked: true,
      ),
      priority: .urgent,
      dayPeriod: .am,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    TaskModel(
      id: '2',
      taskId: '#0982',
      title: 'UI Component Library Update',
      description:
          'Refining the button tokens to align with the new Luminous Status design guidelines.',
      status: const TaskStatusModel(
        isApproved: true,
        hasWarning: true,
        isBlocked: false,
      ),
      priority: .normal,
      dayPeriod: .am,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    TaskModel(
      id: '3',
      taskId: '#1105',
      title: 'API Endpoint Documentation',
      description:
          'Updating the legacy and new privacy endpoints. Aligning with current agency standards.',
      status: const TaskStatusModel(
        isApproved: false,
        hasWarning: true,
        isBlocked: false,
      ),
      priority: .normal,
      dayPeriod: .am,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    TaskModel(
      id: '4',
      taskId: '#1029',
      title: 'Email Notification Service',
      description:
          'Migration to the new SMTP provider completed with 100% deliverability rate.',
      status: const TaskStatusModel(
        isApproved: true,
        hasWarning: false,
        isBlocked: false,
      ),
      priority: .normal,
      dayPeriod: .am,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    TaskModel(
      id: '5',
      taskId: '#1130',
      title: 'Database Schema Migration',
      description:
          'Migrating user tables to the new schema with zero downtime deployment strategy.',
      status: const TaskStatusModel(
        isApproved: false,
        hasWarning: true,
        isBlocked: true,
      ),
      priority: .urgent,
      dayPeriod: .pm,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    TaskModel(
      id: '6',
      taskId: '#1088',
      title: 'Mobile Push Notification Setup',
      description:
          'Configuring FCM and APNs integration for iOS and Android platforms.',
      status: const TaskStatusModel(
        isApproved: true,
        hasWarning: false,
        isBlocked: false,
      ),
      priority: .normal,
      dayPeriod: .pm,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  @override
  createTask(task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.add(TaskModel.fromEntity(task));
    return _tasks;
  }

  @override
  deleteTask(String taskId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.removeWhere((task) => task.id == taskId);
    return _tasks;
  }

  @override
  getTasks(dayPeriod) async {
    // await Future.delayed(const Duration(milliseconds: 300));
    // final filtered =
    //     _tasks.where((task) => task.cycle == cycle).toList();
    // return filtered;
    await Future.delayed(const Duration(seconds: 1));

    _counter++;

    if (_counter < 3) {
      throw NetworkException(
        message: "Mock: No internet (attempt $_counter)",
      );
    }
    return _tasks;
  }

  @override
  updateTask(task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final int index = _tasks.indexWhere((t) => t.id == task.id);
    _tasks[index] = TaskModel.fromEntity(task);
    return _tasks;
  }
}

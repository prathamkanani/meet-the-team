import '../../domain/entity/task_entity.dart';

class TaskStatusModel extends TaskStatusEntity {
  const TaskStatusModel({
    required super.isApproved,
    required super.hasWarning,
    required super.isBlocked,
  });
}

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.taskId,
    required super.title,
    required super.description,
    required super.status,
    required super.priority,
    required super.dayPeriod,
    required super.createdAt,
  });

  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      id: task.id,
      taskId: task.taskId,
      title: task.title,
      description: task.description,
      status: task.status,
      priority: task.priority,
      dayPeriod: task.dayPeriod,
      createdAt: task.createdAt,
    );
  }
}

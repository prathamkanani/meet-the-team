import 'package:flutter/material.dart';
import '../../../domain/entity/error.dart';
import '../../../domain/entity/task_entity.dart';

sealed class TaskState {
  final DayPeriod dayPeriod;

  const TaskState({required this.dayPeriod});
}

final class TaskInitialState extends TaskState {
  const TaskInitialState({required super.dayPeriod});
}

final class TaskLoadingState extends TaskState {
  const TaskLoadingState({required super.dayPeriod});
}

final class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoadedState({required super.dayPeriod, required this.tasks});
}

final class TaskErrorState extends TaskState {
  final AppException exception;
  final Future<void> Function() retry;

  const TaskErrorState({
    required super.dayPeriod,
    required this.exception,
    required this.retry,
  });
}

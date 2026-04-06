import 'package:flutter/material.dart';
import '../entity/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks(DayPeriod dayPeriod);
  Future<List<TaskEntity>> createTask(TaskEntity task);
  Future<List<TaskEntity>> updateTask(TaskEntity task);
  Future<List<TaskEntity>> deleteTask(String taskId);
}

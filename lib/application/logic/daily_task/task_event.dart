import 'package:flutter/material.dart';
import '../../../domain/entity/task_entity.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class LoadTasksEvent extends TaskEvent {
  final DayPeriod cycle;

  const LoadTasksEvent(this.cycle);
}

class SwitchCycleEvent extends TaskEvent {
  final DayPeriod cycle;

  const SwitchCycleEvent(this.cycle);
}

class AddTaskEvent extends TaskEvent {
  final TaskEntity task;

  const AddTaskEvent(this.task);
}

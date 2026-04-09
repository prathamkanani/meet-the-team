import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/error.dart';
import '../../../domain/repository/error_repository.dart';
import '../../../domain/repository/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  final ErrorRepository errorRepository;

  // final MockTaskRepository mockRepo;

  TaskBloc(this.taskRepository, this.errorRepository)
    : super(const TaskInitialState(dayPeriod: .am)) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<SwitchCycleEvent>(_onSwitchCycle);
    on<AddTaskEvent>(_onAddTask);

    add(const LoadTasksEvent(.am));
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadingState(dayPeriod: event.cycle));

    try {
      final result = await taskRepository.getTasks(event.cycle);
      emit(TaskLoadedState(tasks: result, dayPeriod: event.cycle));
    } catch (e, stack) {
      final exception = e is AppException
          ? e
          : NetworkException(
              message: "No internet.\nFailed to load task list.",
              error: e,
              trace: stack,
            );
      errorRepository.reportError(exception);
      emit(
        TaskErrorState(
          dayPeriod: event.cycle,
          exception: exception,
          retry: () async => add(LoadTasksEvent(event.cycle)),
        ),
      );
    }
  }

  Future<void> _onSwitchCycle(
    SwitchCycleEvent event,
    Emitter<TaskState> emit,
  ) async {
    add(LoadTasksEvent(event.cycle));
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await taskRepository.createTask(event.task);
    if (state is TaskLoadedState) {
      final currentState = state as TaskLoadedState;
      if (event.task.dayPeriod == currentState.dayPeriod) {
        emit(TaskLoadedState(dayPeriod: currentState.dayPeriod, tasks: result));
      }
    }
  }
}

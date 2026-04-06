import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/base_container.dart';
import '../config/app_spacing.dart';
import 'widgets/add_task_sheet.dart';
import 'widgets/closing_timer_badge.dart';
import 'widgets/cycle_toggle.dart';
import 'widgets/task_card.dart';
import '../../infrastructure/app_injector.dart';
import '../../application/logic/daily_task/task_bloc.dart';
import '../../application/logic/daily_task/task_event.dart';
import '../../application/logic/daily_task/task_state.dart';
import '../../domain/entity/task_entity.dart';
import '../common/error_page.dart';
import '../config/app_theme.dart';

class DailyTaskHomePage extends StatefulWidget {
  const DailyTaskHomePage({super.key});

  @override
  State<DailyTaskHomePage> createState() => _DailyTaskHomePageState();
}

class _DailyTaskHomePageState extends State<DailyTaskHomePage> {
  late final TaskBloc _taskBloc;
  bool _isErrorPageOpen = false;

  @override
  void initState() {
    super.initState();
    _taskBloc = locator.get();
  }

  @override
  void dispose() {
    _taskBloc.close();
    super.dispose();
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: _taskBloc, child: const AddTaskSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              surfaceTintColor: AppColors.background,
              backgroundColor: AppColors.background,
              title: Row(
                children: [
                  const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
                  AppSpacing.w08,
                  const Expanded(
                    child: Text('Daily Task', style: AppTextStyles.appBarTitle),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.userBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder<TaskBloc, TaskState>(
              bloc: _taskBloc,
              builder: (_, state) {
                return PinnedHeaderSliver(
                  child: Container(
                    color: AppColors.background,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: .max,
                        mainAxisAlignment: .center,
                        children: [
                          CycleToggle(
                            selected: state.dayPeriod,
                            onChanged: (cycle) {
                              _taskBloc.add(SwitchCycleEvent(cycle));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            SliverPadding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
              sliver: BlocBuilder<TaskBloc, TaskState>(
                bloc: _taskBloc,
                builder: (context, state) {
                  return const SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: .center,
                      mainAxisSize: .min,
                      children: [
                        ClosingTimerBadge(duration: Duration(hours: 12)),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverPadding(
              padding: const EdgeInsetsGeometry.all(16),
              sliver: BlocConsumer<TaskBloc, TaskState>(
                bloc: _taskBloc,
                listener: (context, state) {
                  if (state is TaskErrorState && !_isErrorPageOpen) {
                    _isErrorPageOpen = true;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ErrorPage(
                          exception: state.exception!,
                          retry: () async {
                            _taskBloc.add(LoadTasksEvent(state.dayPeriod));
                            return;
                          },
                        ),
                      ),
                    ).then((_) => _isErrorPageOpen = false);
                  } else if (state is TaskLoadedState && _isErrorPageOpen) {
                    Navigator.pop(context);
                  }
                },
                builder: (_, state) {
                  return switch (state) {
                    TaskInitialState() => const SliverToBoxAdapter(
                      child: Loader(),
                    ),
                    TaskLoadingState() => const SliverToBoxAdapter(
                      child: Loader(),
                    ),
                    TaskLoadedState() => TaskList(
                      tasks: state.tasks,
                      dayPeriod: state.dayPeriod,
                      onAdd: () => _showAddTaskSheet(context),
                    ),
                    TaskErrorState() => const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: AddTaskButton(onTap: _showAddTaskSheet),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final DayPeriod cycle;
  final VoidCallback onAdd;

  const _EmptyState({required this.cycle, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            cycle == .am ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
            color: AppColors.statusNeutral,
            size: 48,
          ),
          AppSpacing.h16,
          Text(
            'No tasks in ${cycle == .am ? 'AM' : 'PM'} cycle',
            style: AppTextStyles.cardTitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.h08,
          const Text(
            'Tap the button below to add your first task.',
            style: AppTextStyles.cardDescription,
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<TaskEntity> tasks;
  final DayPeriod dayPeriod;
  final VoidCallback onAdd;

  const TaskList({
    super.key,
    required this.tasks,
    required this.dayPeriod,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return SliverToBoxAdapter(
        child: _EmptyState(cycle: dayPeriod, onAdd: onAdd),
      );
    }
    return SliverList.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, _) => AppSpacing.h16,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(task: task, onTap: () {});
      },
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.textPrimary,
        strokeWidth: 2,
      ),
    );
  }
}

class AddTaskButton extends StatelessWidget {
  final void Function(BuildContext) onTap;

  const AddTaskButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: BaseContainer(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          backgroundColor: AppColors.addTaskBg,
          shadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: .center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
              AppSpacing.w08,
              Text('Add Task', style: AppTextStyles.addTaskLabel),
            ],
          ),
        ),
      ),
    );
  }
}

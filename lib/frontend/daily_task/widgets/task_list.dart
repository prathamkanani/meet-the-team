import 'package:flutter/material.dart';
import '../../../domain/entity/task_entity.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';
import 'task_card.dart';

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
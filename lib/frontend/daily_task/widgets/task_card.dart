import 'package:flutter/material.dart';
import 'package:meet_the_team/domain/entity/task_entity.dart';
import 'package:meet_the_team/frontend/config/app_spacing.dart';
import '../../config/app_theme.dart';
import 'task_status_pill.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.cardPadding),
        decoration: ShapeDecoration(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          ),
          color: AppColors.cardBackground,
          shadows: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.taskId, style: AppTextStyles.ticketId),
            AppSpacing.h04,

            Text(task.title, style: AppTextStyles.cardTitle),
            AppSpacing.h08,

            Text(
              task.description,
              style: AppTextStyles.cardDescription,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpacing.h16,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskStatusPill(status: task.status),
                _LightningBolt(isActive: task.priority == TaskPriority.urgent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LightningBolt extends StatelessWidget {
  final bool isActive;

  const _LightningBolt({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive ? AppColors.boltActiveBg : AppColors.boltInactiveBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.bolt_rounded,
        color: isActive ? AppColors.boltActive : AppColors.boltInactive,
        size: 20,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/app_spacing.dart';
import '../../../domain/entity/task_entity.dart';
import '../../config/app_theme.dart';

class TaskStatusPill extends StatelessWidget {
  final TaskStatusEntity status;

  const TaskStatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.statusPillBg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StatusIcon(
            icon: Icons.check_circle_rounded,
            isActive: status.isApproved,
            activeColor: AppColors.statusCheckGreenBg,
            inactiveColor: AppColors.statusNeutral,
          ),
          AppSpacing.w08,
          _StatusIcon(
            icon: Icons.warning_rounded,
            isActive: status.hasWarning,
            activeColor: AppColors.statusWarnOrangeBg,
            inactiveColor: AppColors.statusNeutral,
          ),
          AppSpacing.w08,
          _StatusIcon(
            icon: Icons.block_rounded,
            isActive: status.isBlocked,
            activeColor: AppColors.statusBlockRedBg,
            inactiveColor: AppColors.statusNeutral,
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const _StatusIcon({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.statusIconSize,
      height: AppDimensions.statusIconSize,
      decoration: BoxDecoration(
        color: isActive ? activeColor : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 18,
        color: isActive ? AppColors.onSurface : AppColors.statusNeutral,
      ),
    );
  }
}

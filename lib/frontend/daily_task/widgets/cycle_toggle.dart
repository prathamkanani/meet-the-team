import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/daily_task/task_bloc.dart';
import '../../../application/logic/daily_task/task_event.dart';
import '../../../application/logic/daily_task/task_state.dart';
import '../../common/base_container.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';

class AMPMCycle extends StatelessWidget {
  final TaskBloc _taskBloc;

  const AMPMCycle({super.key, required TaskBloc taskBloc})
    : _taskBloc = taskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _taskBloc,
      builder: (_, state) {
        return PinnedHeaderSliver(
          child: Container(
            color: AppColors.background,
            padding: const EdgeInsets.all(16),
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
        );
      },
    );
  }
}

class CycleToggle extends StatelessWidget {
  final DayPeriod selected;
  final ValueChanged<DayPeriod> onChanged;

  const CycleToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      height: MediaQuery.heightOf(context) * 0.08,
      width: MediaQuery.widthOf(context) * 0.8,
      borderColor: AppColors.aMPMCycleBorder,
      gradient: const LinearGradient(
        colors: [
          AppColors.background,
          AppColors.aMPMCycleBgColor,
          AppColors.background,
          AppColors.aMPMCycleBgColor,
        ],
        stops: [0.25, 0.5, 0.75, 1.0],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: _CycleTab(
              label: 'AM Cycle',
              emoji: '☀️',
              isSelected: selected == DayPeriod.am,
              onTap: () => onChanged(DayPeriod.am),
            ),
          ),
          Expanded(
            child: _CycleTab(
              label: 'PM Cycle',
              emoji: '🌙',
              isSelected: selected == DayPeriod.pm,
              onTap: () => onChanged(DayPeriod.pm),
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleTab extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  const _CycleTab({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BaseAnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: MediaQuery.heightOf(context) * 0.08,
        gradient: isSelected
            ? const LinearGradient(
                colors: [AppColors.amCycleActive, AppColors.cardBackground],
                stops: [0.5, 1.0],
              )
            : null,
        border: isSelected
            ? const BorderSide(color: AppColors.amCycleBorder, width: 1.5)
            : null,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(emoji),
            AppSpacing.w08,
            Text(
              label,
              style: isSelected
                  ? AppTextStyles.cycleLabel
                  : AppTextStyles.cycleLabelInactive,
            ),
          ],
        ),
      ),
    );
  }
}

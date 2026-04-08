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
    final ColorScheme cs = ColorScheme.of(context);

    return BlocBuilder<TaskBloc, TaskState>(
      bloc: _taskBloc,
      builder: (_, state) {
        return PinnedHeaderSliver(
          child: Container(
            color: cs.surfaceContainerHighest,
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
    final ColorScheme cs = ColorScheme.of(context);
    final AppColorsExtension cse = Theme.of(context).extension()!;

    return BaseContainer(
      height: MediaQuery.heightOf(context) * 0.08,
      width: MediaQuery.widthOf(context) * 0.8,
      borderColor: cse.amPmCycleBorder,
      backgroundColor: cs.surfaceContainerHighest,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: _CycleTab(
              label: 'AM Cycle',
              emoji: '☀️',
              isSelected: selected == DayPeriod.am,
              isAM: selected == DayPeriod.am,
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
  final bool isAM;
  final VoidCallback onTap;

  const _CycleTab({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
    this.isAM = true,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = ColorScheme.of(context);
    final AppColorsExtension cse = Theme.of(context).extension()!;
    final TextTheme th = TextTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: BaseAnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: MediaQuery.heightOf(context) * 0.08,
        gradient: isSelected
            ? LinearGradient(
                colors: [cse.amActive, cs.surfaceContainerHighest],
                stops: [0.5, 1.0],
              )
            : isAM
            ? LinearGradient(
                colors: [cs.surfaceContainerHighest, cse.pmInactive],
                stops: [0.5, 1.0],
              )
            : LinearGradient(
                colors: [cse.pmInactive, cs.surfaceContainerHighest],
                stops: [0.5, 1.0],
              ),
        border: isSelected
            ? BorderSide(color: cse.amPmBorder, width: 1.5)
            : null,
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Text(emoji),
            AppSpacing.w08,
            Text(
              label,
              style: isSelected
                  ? th.titleMedium?.copyWith(color: cs.onSurface)
                  : th.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

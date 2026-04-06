import 'package:flutter/material.dart';
import '../../common/base_container.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';

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

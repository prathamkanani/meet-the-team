import 'package:flutter/material.dart';
import '../../common/base_container.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';

class AddTaskButton extends StatelessWidget {
  final void Function(BuildContext) onTap;

  const AddTaskButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension cse = Theme.of(context).extension()!;
    final ColorScheme cs = ColorScheme.of(context);
    final TextTheme th = TextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => onTap(context),
        child: BaseContainer(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          backgroundColor: cs.primary,
          shadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: .center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: cs.onPrimary,
                size: 20,
              ),
              AppSpacing.w08,
              Text(
                'Add Task',
                style: th.bodyMedium?.copyWith(color: cs.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

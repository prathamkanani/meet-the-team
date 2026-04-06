import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_the_team/application/logic/daily_task/task_bloc.dart';
import 'package:meet_the_team/domain/entity/task_entity.dart';
import 'package:meet_the_team/frontend/config/app_spacing.dart';
import '../../../application/logic/daily_task/task_event.dart';
import '../../../application/logic/daily_task/task_state.dart';
import '../../config/app_theme.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _isUrgent = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_titleController.text.trim().isEmpty) return;

    final state = context.read<TaskBloc>().state;
    final cycle = state.dayPeriod;
    final now = DateTime.now();

    final task = TaskEntity(
      id: now.millisecondsSinceEpoch.toString(),
      taskId: '#${(1200 + now.second).toString()}',
      title: _titleController.text.trim(),
      description: _descController.text.trim().isEmpty
          ? 'No description provided.'
          : _descController.text.trim(),
      status: const TaskStatusEntity(
        isApproved: false,
        hasWarning: false,
        isBlocked: false,
      ),
      priority: _isUrgent ? TaskPriority.urgent : TaskPriority.normal,
      dayPeriod: cycle,
      createdAt: now,
    );

    context.read<TaskBloc>().add(AddTaskEvent(task));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          AppSpacing.h16,

          Text(
            'Add New Task',
            style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
          ),
          AppSpacing.h16,

          _InputField(
            controller: _titleController,
            label: 'Task title',
            maxLines: 1,
          ),
          AppSpacing.h16,

          _InputField(
            controller: _descController,
            label: 'Description (optional)',
            maxLines: 3,
          ),
          AppSpacing.h16,

          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isUrgent = !_isUrgent),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44,
                  height: 26,
                  decoration: BoxDecoration(
                    color: _isUrgent
                        ? AppColors.boltActiveBg
                        : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: _isUrgent
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.w08,
              const Text(
                'Mark as urgent',
                style: AppTextStyles.cardDescription,
              ),
            ],
          ),
          AppSpacing.h16,

          // Submit button
          BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () => _submit(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: AppColors.addTaskBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Add to ${state.dayPeriod == .am ? 'AM' : 'PM'} Cycle',
                    style: AppTextStyles.addTaskLabel,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const _InputField({
    required this.controller,
    required this.label,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: AppTextStyles.cardTitle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppTextStyles.cardDescription,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/daily_task/task_bloc.dart';
import '../../../application/logic/daily_task/task_state.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';

class ClosingTimer extends StatelessWidget {
  final TaskBloc taskBloc;

  const ClosingTimer({super.key, required this.taskBloc});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      sliver: BlocBuilder<TaskBloc, TaskState>(
        bloc: taskBloc,
        builder: (context, state) {
          return const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: .center,
              mainAxisSize: .min,
              children: [ClosingTimerBadge(duration: Duration(hours: 12))],
            ),
          );
        },
      ),
    );
  }
}

class ClosingTimerBadge extends StatelessWidget {
  final Duration duration;

  const ClosingTimerBadge({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    final AppColorsExtension cse = Theme.of(context).extension()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: cse.timerBg,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: cse.timerBorder, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, color: cse.timerText),
          AppSpacing.w08,
          TimerText(duration: duration),
        ],
      ),
    );
  }
}

class TimerText extends StatefulWidget {
  final Duration duration;

  const TimerText({super.key, required this.duration});

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

  // We need this when the duration needs to change dynamically.
  // We use didUpdateWidget when we copied widget.someField
  // into local state and that value needs to change later.
  @override
  void didUpdateWidget(covariant TimerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _timer?.cancel();
      _remaining = widget.duration;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme th = TextTheme.of(context);
    final AppColorsExtension cse = Theme.of(context).extension()!;

    return Text(
      'Closing in: ${_formatDuration(_remaining)}',
      style: th.titleSmall?.copyWith(color: cse.timerText),
    );
  }

  //region Custom Methods
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        } else {
          _remaining = const Duration(hours: 12);
        }
      });
    });
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  //endregion
}

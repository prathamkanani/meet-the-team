import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/app_spacing.dart';
import '../../config/app_theme.dart';

class ClosingTimerBadge extends StatefulWidget {
  final Duration duration;

  const ClosingTimerBadge({super.key, required this.duration});

  @override
  State<ClosingTimerBadge> createState() => _ClosingTimerBadgeState();
}

class _ClosingTimerBadgeState extends State<ClosingTimerBadge> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

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

  @override
  void didUpdateWidget(covariant ClosingTimerBadge oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _remaining = widget.duration;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.timerBadge,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.timerBorder, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer, color: AppColors.stopWatch,),
          AppSpacing.w08,
          Text(
            'Closing in: ${_formatDuration(_remaining)}',
            style: AppTextStyles.timerText,
          ),
        ],
      ),
    );
  }
}

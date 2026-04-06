import 'package:flutter/material.dart';

enum TaskPriority { normal, urgent }

enum BlockStatus { blocked, unBlocked }

class TaskEntity {
  final String id;
  final String taskId;
  final String title;
  final String description;
  final TaskStatusEntity status;
  final TaskPriority priority;
  final DayPeriod dayPeriod;
  final DateTime createdAt;
  // Add RAG color

  const TaskEntity({
  required this.id,
  required this.taskId,
  required this.title,
  required this.description,
  required this.status,
  required this.priority,
  required this.dayPeriod,
  required this.createdAt,
  });
}

class TaskStatusEntity {
  final bool isApproved;
  final bool hasWarning;
  final bool isBlocked;

  const TaskStatusEntity({
    required this.isApproved,
    required this.hasWarning,
    required this.isBlocked,
  });
}

import 'package:flutter/material.dart';
import 'frontend/common/error_page.dart';
import 'frontend/config/app_theme.dart';
import 'frontend/daily_task/daily_task_home_page.dart';
import 'infrastructure/app_injector.dart';

void main() async {
  await DependencyInjector().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const DailyTaskHomePage(),
    );
  }
}
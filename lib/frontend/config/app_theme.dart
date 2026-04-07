import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // colorScheme: ColorScheme(
    //   brightness: .light,
    //   primary: primary,
    //   onPrimary: Color(0xFFFFFFFF),
    //   secondary: secondary,
    //   onSecondary: onSecondary,
    //   error: Color(0xFF9e403c),
    //   onError: Color(0xFFFFFFFF),
    //   surface: Color(0xFFf7f9fb),
    //   onSurface: Color(0xFFFFFFFF),
    // ),
  );
}

class AppColors {
  static const Color onSurface = Color(0xFFFFFFFF);

  // Background
  static const Color background = Color(0xFFf7f9fb);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // AM/PM Cycle toggle
  static const Color amCycleActive = Color(0xFFfef2c5);
  static const Color amCycleBorder = Color(0xFFF5C842);
  static const Color pmCycleInactive = Color(0xFFEFF2F6);
  static const Color aMPMCycleBorder = Color(0xFFf0f4f7);
  static const Color aMPMCycleBgColor = Color(0xFFe4ebf9);

  // Timer badge
  static const Color stopWatch = Color(0xFF865400);
  static const Color timerBadge = Color(0xFFf7e6cb);
  static const Color timerText = Color(0xFF8B6914);
  static const Color timerBorder = Color(0xFFF5C842);

  // Status icons
  static const Color statusCheckGreen = Color(0xFF006e2f);
  static const Color statusCheckGreenBg = Color(0xFF006e2f);
  static const Color statusWarnOrange = Color(0xFFf7a011);
  static const Color statusWarnOrangeBg = Color(0xFFf7a011);
  static const Color statusBlockRed = Color(0xFF9e403c);
  static const Color statusBlockRedBg = Color(0xFF9e403c);
  static const Color statusNeutral = Color(0xFF566165);
  static const Color statusNeutralBg = Color(0xFF566165);

  // Lightning bolt
  static const Color boltActive = Color(0xFFFFFFFF);
  static const Color boltActiveBg = Color(0xFF555e74);
  static const Color boltInactive = Color(0xFFcbcfd1);
  static const Color boltInactiveBg = Color(0xFFf7f9fb);

  // Text
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF566165);

  // Add Task Button
  static const Color addTaskBg = Color(0xFF525b71);
  static const Color addTaskText = Color(0xFFFFFFFF);

  // Status pill background
  static const Color statusPillBg = Color(0xFFF3F4F6);

  // User background
  static const Color userBg = Color(0xFF324854);
  static const Color userIcon = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle cycleLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle cycleLabelInactive = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const TextStyle timerText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.timerText,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle ticketId = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle addTaskLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.addTaskText,
    letterSpacing: 0.1,
  );
}

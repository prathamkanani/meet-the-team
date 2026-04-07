import 'package:flutter/material.dart';

@immutable
class AppErrorTheme extends ThemeExtension<AppErrorTheme> {
  final Color background;
  final Color textColor;
  final Color iconColor;

  const AppErrorTheme({
    required this.background,
    required this.textColor,
    required this.iconColor,
  });

  @override
  ThemeExtension<AppErrorTheme> copyWith({
    Color? background,
    Color? textColor,
    Color? iconColor,
  }) {
    return AppErrorTheme(
      background: background ?? this.background,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  ThemeExtension<AppErrorTheme> lerp(
    covariant ThemeExtension<AppErrorTheme>? other,
    double t,
  ) {
    if (other is! AppErrorTheme) return this;
    return AppErrorTheme(
      background: Color.lerp(background, other.background, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }
}

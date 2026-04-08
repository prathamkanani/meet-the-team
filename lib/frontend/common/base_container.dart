import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final double? height, width, borderRadius;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;
  final Widget child;

  const BaseContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.shadow,
    this.gradient,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50),
          side: borderColor != null
              ? BorderSide(color: borderColor!, width: 6)
              : BorderSide.none,
        ),
        color: backgroundColor,
        gradient: gradient,
        shadows: shadow,
      ),
      child: child,
    );
  }
}

class BaseAnimatedContainer extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final double? height, width;
  final BorderSide? border;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final List<BoxShadow>? shadow;
  final Gradient? gradient;
  final Widget child;

  const BaseAnimatedContainer({
    super.key,
    required this.child,
    required this.duration,
    required this.curve,
    this.border,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.shadow,
    this.gradient,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeInOut,
      height: height,
      width: width,
      padding: padding,
      decoration: ShapeDecoration(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(50),
          side: border != null ? border! : BorderSide.none,
        ),
        gradient: gradient,
      ),
      child: child
    );
  }
}

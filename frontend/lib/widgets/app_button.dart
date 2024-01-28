import 'package:flutter/material.dart';
import 'package:frontend/data/data.dart';

enum AppButtonStyle {
  primary,
  secondary;

  Color get backgroundColor => switch (this) {
        primary => AppColors.purplePrimary,
        secondary => Colors.white,
      };

  TextStyle get textStyle => switch (this) {
        primary => AppTextStyles.buttonTextPrimary,
        secondary => AppTextStyles.buttonTextSecondary,
      };

  Border? get border => switch (this) {
        primary => null,
        secondary => Border.all(color: AppColors.greyLighter),
      };
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    required this.onPressed,
    required this.child,
  });

  AppButton.text(
    String text, {
    super.key,
    required AppButtonStyle style,
    required this.onPressed,
  })  : backgroundColor = style.backgroundColor,
        borderRadius = defaultBorderRadius,
        border = style.border,
        child = Text(text, style: style.textStyle);

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final VoidCallback? onPressed;
  final Widget child;

  static BorderRadius defaultBorderRadius = BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius;
    final decoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: border,
    );

    return Opacity(
      opacity: onPressed != null ? 1 : 0.4,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

import 'package:core/core.dart';
import 'package:fanofa/src/app/localization/localization_cubit.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/src/gradient_colors.dart';
import 'package:flutter/material.dart';

class BottomPersistenceButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool transparent;

  const BottomPersistenceButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.transparent = true,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = SafeArea(
      minimum: const EdgeInsets.all(20),
      child: IntrinsicHeight(
        child: _Button(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          onPressed: onPressed,
          label: label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );

    if (!transparent) {
      final theme = Theme.of(context);
      final bottomAppBarTheme = theme.bottomAppBarTheme;
      child = Material(
        color: bottomAppBarTheme.color,
        shadowColor: theme.colorScheme.shadow,
        elevation: bottomAppBarTheme.elevation ?? 0,
        child: child,
      );
    }
    return child;
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final Gradient? gradient;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.padding,
    this.fontSize,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _Button(
      label: label,
      gradient: gradient,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      padding: padding,
      fontSize: fontSize,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final EdgeInsets? padding;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.fontWeight,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    //final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.of(context).disabledButton,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 10,
          ),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Center(
          child: CommonText(label,
              size: fontSize ?? 16,
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w600),
        ),
      ),
    );
  }
}

class TertiaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const TertiaryButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _Button(
      label: label,
      onPressed: onPressed,
      backgroundColor: colorScheme.tertiaryContainer,
      foregroundColor: colorScheme.onTertiary,
    );
  }
}

class ErrorButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const ErrorButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return _Button(
      label: label,
      onPressed: onPressed,
      backgroundColor: colorScheme.error,
      foregroundColor: colorScheme.onError,
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;
  final double? fontSize;
  final Gradient ? gradient;

  const _Button({
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.textColor,
    this.fontWeight,
    this.shape,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ??  AppGradients.of(context).enabledButton,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          padding: padding ??
              const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 10,
              ),
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Center(
          child: CommonText(label,
              size: fontSize ?? 16,
              color: textColor ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w600),
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String iconPath;
  final String btnText;
  final void Function()? onPress;

  const BorderButton({
    super.key,
    required this.iconPath,
    required this.btnText,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: colorScheme.background,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colorScheme.surfaceTint,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPress,
      icon: SvgImageFromAsset.square(
        iconPath,
      ),
      label: CommonText.medium(
        btnText,
        size: 16,
      ),
    );
  }
}

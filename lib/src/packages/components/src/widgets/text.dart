import 'dart:ui';

import 'package:fanofa/src/packages/resouces/src/theme/theme.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool isItalic;
  final double? height;
  final double? letterSpacing;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final Color? decorationColor;
  final VoidCallback? onTap;

  const CommonText(
    this.text, {
    this.size = 12,
    this.onTap,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
  });

  const CommonText.extraBold(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w800;

  const CommonText.bold(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w700;

  const CommonText.semiBold(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w600;

  const CommonText.medium(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w500;

  const CommonText.regular(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height = 1.5,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w400;

  const CommonText.light(
    this.text, {
    this.size = 12,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.isItalic = false,
    this.height = 1.5,
    this.letterSpacing,
    this.fontFamily,
    this.decoration,
    super.key,
    this.decorationColor,
    this.onTap,
  }) : fontWeight = FontWeight.w300;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultTextStyle = DefaultTextStyle.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        softWrap: true,
        style: defaultTextStyle.style.copyWith(
          fontFamily: fontFamily ?? AppTheme.kFontFamily,
          color: color ?? colorScheme.surfaceTint,
          fontSize: size,
          fontFeatures: [const FontFeature.tabularFigures()],
          fontStyle: isItalic ? FontStyle.italic : null,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing ?? 0,
          decoration: decoration,
          decorationColor: decorationColor ?? colorScheme.onPrimary,
          inherit: true,
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
    );
  }
}

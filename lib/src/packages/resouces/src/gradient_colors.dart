import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AppGradients {
  static final AppGradients _instance = AppGradients._private();

  AppGradients._private();

  static BuildContext? _context;

  static AppGradients of(BuildContext context) {
    _context = context;
    return _instance;
  }

  ColorScheme get _colorScheme => _context!.colorScheme;

  LinearGradient _linearGradient(List<Color> colors, {AlignmentGeometry? begin, AlignmentGeometry? end}) =>
      LinearGradient(
        colors: colors,
        begin: begin ?? AlignmentDirectional.centerStart,
        end: end ?? AlignmentDirectional.centerEnd,
      );

  LinearGradient get enabledButton => _linearGradient(
    [ _colorScheme.primary,_colorScheme.onPrimary],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

  LinearGradient get disabledButton => _linearGradient(
    [ _colorScheme.primary.withOpacity(0.5),_colorScheme.onPrimary.withOpacity(0.5)],
    begin: AlignmentDirectional.topCenter,
    end: AlignmentDirectional.bottomCenter,
  );

 // LinearGradient get primaryDark => _linearGradient([AppTheme.darkTheme.colorScheme.primary, AppTheme.darkTheme.colorScheme.secondary]);

  LinearGradient get secondaryDark => _linearGradient(const [Color(0xFF4A00E0), Color(0xFF8E2DE2)]);

  LinearGradient get grayBlue => _linearGradient(const [Color(0xFF4E54C8), Color(0xFF8F94FB)]);

  LinearGradient getLinearGradient(int index) => <LinearGradient>[
    //primaryDark,
    grayBlue,
    secondaryDark,
  ][index];
}
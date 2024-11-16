import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';

export 'theme_state.dart';

class ThemeCubit extends BlocBase<ThemeState> {
  ThemeCubit(super.initialState) {
    if (state.themeMode == ThemeMode.system) {
      Timer.run(_onPlatformBrightnessChanged);
      WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
    }
  }

  void onThemeUpdated(Brightness brightness) {
    emit(state.copyWith(brightness: brightness));
  }

  void _onPlatformBrightnessChanged() {
    emit(state.copyWith(brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness));
  }

  void onThemeChanged(ThemeMode themeMode) {
    Brightness? brightness;
    switch (themeMode) {
      case ThemeMode.system:
        if (state.themeMode != ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
        }
        brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        break;
      case ThemeMode.light:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.dark;
        break;
    }

    emit(state.copyWith(themeMode: themeMode, brightness: brightness));
  }
}

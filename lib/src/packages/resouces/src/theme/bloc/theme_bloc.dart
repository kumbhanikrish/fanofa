import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'theme_event.dart';
import 'theme_state.dart';

export 'theme_event.dart';
export 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeMode? themeMode}) : super(ThemeState(themeMode: themeMode ?? ThemeMode.system)) {
    on<ThemeChanged>(_onThemeChanged);
    on<ThemeUpdated>(_onThemeUpdated);
    if (themeMode == ThemeMode.system) {
      Timer.run(_onPlatformBrightnessChanged);
      WidgetsBinding.instance.window.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
    }
  }

  void _onPlatformBrightnessChanged() {
    add(ThemeUpdated(brightness: WidgetsBinding.instance.window.platformBrightness));
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    Brightness? brightness;
    switch (event.themeMode) {
      case ThemeMode.system:
        if (state.themeMode != ThemeMode.system) {
          WidgetsBinding.instance.window.onPlatformBrightnessChanged = _onPlatformBrightnessChanged;
        }
        brightness = WidgetsBinding.instance.window.platformBrightness;
        break;
      case ThemeMode.light:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.window.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        if (state.themeMode == ThemeMode.system) {
          WidgetsBinding.instance.window.onPlatformBrightnessChanged = null;
        }
        brightness = Brightness.dark;
        break;
    }

    emit(state.copyWith(themeMode: event.themeMode, brightness: brightness));
  }

  void _onThemeUpdated(ThemeUpdated event, Emitter<ThemeState> emit) {
    emit(state.copyWith(brightness: event.brightness));
  }
}

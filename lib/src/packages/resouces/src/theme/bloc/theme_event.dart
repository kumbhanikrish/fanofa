
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;

  const ThemeChanged({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

class ThemeUpdated extends ThemeEvent {
  final Brightness brightness;

  const ThemeUpdated({required this.brightness});

  @override
  List<Object> get props => [brightness];
}

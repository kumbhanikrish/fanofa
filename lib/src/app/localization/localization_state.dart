import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocalizationState extends Equatable {
  final List<Language> listLanguage;
  final List<Locale> supportedLocales;
  final Locale locale;

  const LocalizationState({
    required this.supportedLocales,
    required this.listLanguage,
    required this.locale,
  });

  @override
  List<Object?> get props => [locale, supportedLocales, listLanguage];

  LocalizationState copyWith({
    List<Language>? listLanguage,
    List<Locale>? supportedLocales,
    Locale? locale,
  }) {
    return LocalizationState(
      listLanguage: listLanguage ?? this.listLanguage,
      supportedLocales: supportedLocales ?? this.supportedLocales,
      locale: locale ?? this.locale,
    );
  }
}

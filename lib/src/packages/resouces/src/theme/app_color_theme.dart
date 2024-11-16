import 'package:flutter/material.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final Color failure;
  final Color success;
  final Color link;

  Color get failureContainer => failure.withAlpha(50);

  Color get onFailureContainer => failure;

  Color get successContainer => success.withAlpha(50);

  Color get onSuccessContainer => success;

  const AppColorTheme({
    required this.failure,
    required this.success,
    required this.link,
  });

  @override
  ThemeExtension<AppColorTheme> copyWith({
    Color? failure,
    Color? success,
    Color? link,
  }) {
    return AppColorTheme(
      failure: failure ?? this.failure,
      success: success ?? this.success,
      link: link ?? this.link,
    );
  }

  @override
  ThemeExtension<AppColorTheme> lerp(ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) return this;
    return copyWith(
      failure: Color.lerp(failure, other.failure, t),
      success: Color.lerp(success, other.success, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AppColorTheme && runtimeType == other.runtimeType && failure == other.failure && success == other.success;

  @override
  int get hashCode => failure.hashCode ^ success.hashCode;
}

extension AppColorThemeExtension on BuildContext {
  AppColorTheme get appColor {
    var extension = Theme.of(this).extension<AppColorTheme>();
    assert(extension != null);
    return extension!;
  }
}

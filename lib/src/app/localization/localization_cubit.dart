import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:fanofa/src/di/dependency.dart';
import 'package:fanofa/src/l10n/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'localization_state.dart';

export 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  factory LocalizationCubit({Locale? currentLocale}) {
    var locale = currentLocale;
    if (locale != null) {
      var systemLocale = WidgetsBinding.instance.window.locale;
      locale = /*S.delegate.isSupported(systemLocale)
          ? Locale.fromSubtags(languageCode: systemLocale.languageCode)
          : */const Locale.fromSubtags(languageCode: "ja");
      Singletons.I.pref.locale = locale;
    }

    var state = LocalizationState(
      listLanguage: const [
        Language(name: "English", code: "en"),
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale ?? Locale('en'),
    );

    return LocalizationCubit._private(state);
  }

  LocalizationCubit._private(super.state);

  static LocalizationCubit of(BuildContext context, [bool listen = false]) {
    return BlocProvider.of<LocalizationCubit>(context, listen: listen);
  }

  void updateLocale(String localeCode) {
    var locale = Locale.fromSubtags(languageCode: localeCode);
    bool isSupported = S.delegate.isSupported(locale);
    if (isSupported) emit(state.copyWith(locale: locale));
  }
}

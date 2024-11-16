import 'package:core/src/loader.dart';
import 'package:flutter/material.dart';

mixin LoadingMixin {
  late final _navigator = Navigator.of(context);
  Route? _dialogRoute;

  BuildContext get context;

  void handleLoading(bool isLoading) {
    if (isLoading) {
      startLoading();
    } else {
      stopLoading();
    }
  }

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: _navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      settings: const RouteSettings(name: "/loading_dialog"),
      themes: themes,
      builder: (context) => const LoadingDialog(),
    );
  }

  void startLoading() {
    if (_dialogRoute != null) return;
    _dialogRoute = _buildDialogRoute(context);
    _navigator.push(_dialogRoute!);
  }

  void stopLoading() {
    if (_dialogRoute != null) _navigator.removeRoute(_dialogRoute!);
    _dialogRoute = null;
  }
}

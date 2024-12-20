import 'package:flutter/widgets.dart';

import 'generated/l10n.dart';

export 'generated/l10n.dart';

extension LocalizationsExtension on BuildContext {
  S get l10n => S.of(this);
}

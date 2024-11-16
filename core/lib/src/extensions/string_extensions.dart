import 'package:intl/intl.dart';

extension $StringExtension on String {
  DateTime parseUtcDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parseUTC(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  DateTime parseLocalDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    var time = DateFormat(format).parse(replaceAll("T", " ").replaceAll("Z", " "));
    return time;
  }

  String emailFormat([int? number = 3]) {
    if (isEmpty) return this;
    var parts = split('@');
    if (parts.first.length > 3) {
      return "${parts.first.substring(0, number).padRight(parts.first.length, '*')}@${parts.last}";
    }
    return this;
  }

  String phoneFormat() {
    if (isEmpty) return this;
    if (length > 6) {
      return substring(0, 3).padRight(length - 3, '*') + substring(length - 3, length);
    }
    return this;
  }

  String get capitalize {
    if (length <= 1) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String unixStringToDatetime({String dateFormat = "MMM dd, yyyy hh:mm a"}) {
    int unixInt = toInt();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(unixInt * 1000);
    return DateFormat(dateFormat).format(date);
  }

}

extension $NullableStringExtension on String? {
  bool get isNullOrEmpty => (this?.trim() ?? "").isEmpty;

  int toInt() {
    return this == null ? 0 : int.tryParse(this!) ?? 0;
  }

  double toDouble() {
    return this == null ? 0 : double.tryParse(this!) ?? 0.0;
  }
}

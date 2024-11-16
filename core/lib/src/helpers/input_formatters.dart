import 'dart:math' as math;

import 'package:core/src/extensions/extensions.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final int length;
  final bool allowFloating;
  final int decimalPoint;

  NumberInputFormatter({this.length = 255, this.allowFloating = false, this.decimalPoint = 2});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > length) return oldValue;
    if (newValue.text.length > oldValue.text.length) {
      if (allowFloating) {
        if (newValue.text.contains(".") && newValue.text.split(".").last.length > decimalPoint) {
          return oldValue;
        }
        return double.tryParse(newValue.text) != null ? newValue : oldValue;
      } else {
        return int.tryParse(newValue.text) != null ? newValue : oldValue;
      }
    } else {
      return newValue;
    }
  }
}

class MobileNumberInputFormatter extends TextInputFormatter {
  MobileNumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.replaceAll(" ", "").length > 11) return oldValue;
    if (newValue.text.length > oldValue.text.length) {
      if (int.tryParse(newValue.text.replaceAll(" ", "")) == null) {
        return oldValue;
      }
      var newText = newValue.text.replaceAll(" ", "");
      StringBuffer buffer = StringBuffer();
      for (int index = 0; index < newText.length; index++) {
        buffer.write(newText[index]);
        if (index == 2 || index == 5) buffer.write(" ");
      }
      return TextEditingValue(text: buffer.toString(), selection: TextSelection.collapsed(offset: buffer.length));
    } else {
      var newText = newValue.text.trim();
      return newValue.copyWith(text: newText.trim(), selection: TextSelection.collapsed(offset: newText.length));
    }
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll("/", '');
    if (newText.isNotEmpty && int.tryParse(newText) == null) {
      return oldValue;
    } else if (newValue.text.length > 7) {
      return oldValue;
    } else if (newValue.text.length < oldValue.text.length) {
      return newValue;
    } else if (newValue.text.length < 2) {
      return newValue;
    } else if (newValue.text.length == 2) {
      return int.parse(newValue.text) > 12 ? oldValue : newValue;
    }

    var string = _getFormattedCardMonth(newText, false);
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }

  String _getFormattedCardMonth(String cardMonth, [bool padZero = true]) {
    if (cardMonth.isEmpty) return "00/0000";
    var text = padZero ? cardMonth.replaceAll("/", '').padRight(6, "0") : cardMonth;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1) buffer.write('/');
    }
    return buffer.toString().trim();
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text.replaceAll(" ", '').trim();
    if (newValue.text.length < oldValue.text.length) {
      var text = newValue.text.trim();
      return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
    } else if (newText.isNotEmpty && int.tryParse(newValue.text.split(" ").last) == null) {
      return oldValue;
    } else if (newValue.text.length < 4) {
      return newValue;
    } else if (newText.length > 16) {
      return oldValue;
    }
    var string = _getFormattedCardNumber(newText, false);
    return newValue.copyWith(text: string, selection: TextSelection.collapsed(offset: string.length));
  }

  String _getFormattedCardNumber(String cardNumber, [bool padZero = true]) {
    if (cardNumber.isEmpty) return "0000  0000  0000  0000";
    var text = padZero ? cardNumber.replaceAll(" ", '').padRight(16, "0") : cardNumber;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0) buffer.write("  ");
    }
    return buffer.toString().trim();
  }
}

class FormattedAmountInputFormatter extends TextInputFormatter {
  final int? maxDecimalPoint;
  final RegExp regExp = RegExp(r'(^\d*\.?\d*)');

  FormattedAmountInputFormatter([this.maxDecimalPoint]);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    var text = newValue.text.replaceAll(",", "");
    if (!regExp.hasMatch(text)) return oldValue;
    var decimalPoint = text.contains(".") ? text.split(".").last.length : 0;
    if (maxDecimalPoint != null) decimalPoint = math.min(maxDecimalPoint!, decimalPoint);
    final NumberFormat numberFormat = NumberFormat.currency(locale: "en", customPattern: '##,###.##', decimalDigits: decimalPoint);
    String amountString = numberFormat.format(text.toDouble());
    if (text.endsWith(".")) amountString += ".";
    return TextEditingValue(text: amountString, selection: TextSelection.collapsed(offset: amountString.length));
  }
}

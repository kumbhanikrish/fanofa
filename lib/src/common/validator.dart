
import 'package:fanofa/src/l10n/generated/l10n.dart';

import '../packages/components/components.dart';

const kEmailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String? validateMobileNumber(String? value) {
  if (value == null) {
    return null;
  } else if (value.trim().isEmpty) {
    return "Please Enter mobile number!";
  } else if (value.replaceAll(" ", "").length < 10 || value.replaceAll(" ", "").length > 10) {
    return "Please Enter Valid mobile number";
  } else {
    return null;
  }
}

String? validateConfirmPassword(String? value, String password, {bool emptyAllow = false}) {
  if (value == null || emptyAllow) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorConfirmPassword;
  } else if (value != password) {
    return S.current.errorConfirmPasswordDidNotMatch;
  } else {
    return null;
  }
}

String? validatePassword(String? value, {bool checkPasswordPattern = true}) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorPassword;
  } else if (!RegExp(kPasswordPattern).hasMatch(value.trim()) && checkPasswordPattern) {
    return S.current.errorPasswordValid;
  } else {
    return null;
  }
}
/*String? validateEmptyField(String? value,String? message) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return message;
  } else {
    return null;
  }
}*/
String? validateEmail(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorEmail;
  } else if (!RegExp(kEmailPattern).hasMatch(value.trim())) {
    return S.current.validErrorEmail;
  } else {
    return null;
  }
}

String? validateForgotEmailPin(String? value, String loginMail) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorEmail;
  } else if (!RegExp(kEmailPattern).hasMatch(value.trim())) {
    return S.current.validErrorEmail;
  } else if (value.trim() != loginMail) {
    return "Login account email and your enter email doesn't match!";
  } else {
    return null;
  }
}

/*String? validateFirstName(String? value) {
  String pattern = r'^[a-z A-Z]+$';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return S.current.errorFirstName;
  } else if (!regExp.hasMatch(value.trim())) {
    return "Name must be in alphabet";
  } else if (value.length < 3) {
    return "minimum 3 character required for first name";
  }
  return null;
}

String? validateLastName(String? value) {
  String pattern = r'^[a-z,A-Z]+$';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return S.current.errorLastName;
  } else if (!regExp.hasMatch(value.trim())) {
    return "Name must be in alphabet";
  } else if (value.length < 3) {
    return "minimum 3 character required for last name";
  }
  return null;
}*/

String? validateEmptyField(String? value, String fieldName) {
  if (value == null) {
    return null;
  } else if (value.trim().isEmpty) {
    return fieldName;
  } else {
    return null;
  }
}
String? validateSmsCode(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return "Please enter digit code!";
  } else if (value.length > 6) {
    return "please enter valid digit code!";
  } else {
    return null;
  }
}
/*
String? validateOldPassword(String? value, {bool emptyAllow = false}) {
  if (value == null || emptyAllow) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorPleaseEnterPassword;
  } else {
    return null;
  }
}


String? validateFirstName(String? value) {
  String pattern = r'(^[a-z,A-Z, ,_,0-9])';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return S.current.firstNameIsEmpty;
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z, A-Z, 0-9 and _";
  } else if (value.length < 3 || value.length > 28) {
    return "minimum 3 character required for first name";
  }
  return null;
}

String? validateLastName(String? value) {
  String pattern = r'(^[a-z,A-Z, ,_,0-9])';
  RegExp regExp = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return S.current.lastNameIsEmpty;
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z, A-Z, 0-9 and _";
  } else if (value.length < 3 || value.length > 28) {
    return "minimum 3 character required for first name";
  }
  return null;
}

String? validateUserName(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.pleaseEnterUsername;
  } else if (value.length < 3 || value.length > 28) {
    return "minimum 3 character required for first name";
  } else {
    return null;
  }
}

String? validateEmailAndPhone(String? value) {
  if (value == null || value.isEmpty) {
    return S.current.errorPleaseEnterPhoneOrEmail;
  } else if (!RegExp(kEmailPattern).hasMatch(value) && !RegExp(r"^[0-9]{10}$").hasMatch(value)) {
    return S.current.errorEnterTheValidEmailOrPhone;
  }
  return null;
}

String? validatePinCode(String? value) {
  Log.debug("value = ${value?.length}");
  if (value == null || value.isEmpty) {
    return "Please enter area code!";
  } else if (!RegExp(r"^(\d{4}|\d{6})$").hasMatch(value)) {
    return "Please enter valid area code!";
  }
  return null;
}

String? validateCardNumber(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorPleaseEnterCardNumber;
  } else {
    var number = value.replaceAll(" ", "");
    if (number.length < 12 || number.length > 20) {
      return S.current.errorPleaseEnterValidCardNumber;
    } else {
      return null;
    }
  }
}

String? validateCvv(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return S.current.errorPleaseEnterCvvNumber;
  } else if (value.length < 3 || value.length > 4) {
    return S.current.errorPleaseEnterValidCvvNumber;
  } else {
    return null;
  }
}

String? validateSmsCode(String? value) {
  if (value == null) {
    return null;
  } else if (value.isEmpty) {
    return "Please enter digit code!";
  } else if (value.length > 6) {
    return "please enter valid digit code!";
  } else {
    return null;
  }
}
*/

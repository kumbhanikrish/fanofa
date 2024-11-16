// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(permissionName) =>
      "You have permanently denied for ${permissionName} permission. To enable ${permissionName} permission, you need to go to settings and allow us to access ${permissionName}.";

  static String m1(fieldName) => "${fieldName} is required.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("GhanshyamCake"),
        "areYouSureWantToLogout": MessageLookupByLibrary.simpleMessage(
            "Are you sure want to logout?"),
        "btnCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "btnGoToSettings":
            MessageLookupByLibrary.simpleMessage("Go To Settings"),
        "continueTitle": MessageLookupByLibrary.simpleMessage("Continue"),
        "descPermissionDenied": m0,
        "descUserUnauthorized": MessageLookupByLibrary.simpleMessage(
            "Your session has been expired! Please login again to continue using app."),
        "emptyValidation": m1,
        "errorConfirmPassword": MessageLookupByLibrary.simpleMessage(
            "Please enter confirm password!"),
        "errorConfirmPasswordDidNotMatch": MessageLookupByLibrary.simpleMessage(
            "Confirm password didn\'t match with password!"),
        "errorEmail":
            MessageLookupByLibrary.simpleMessage("Please enter email address!"),
        "errorNoInternet": MessageLookupByLibrary.simpleMessage(
            "Unable to connect to network! Please check your network connection and try again."),
        "errorPassword":
            MessageLookupByLibrary.simpleMessage("Please enter password!"),
        "errorPasswordValid": MessageLookupByLibrary.simpleMessage(
            "Password length should be 8 character & must contain capital letter, small letter, number & an special character [!,@,#,\\\$,%,^,&,*,_]."),
        "errorSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something Went Wrong"),
        "errorTimeout": MessageLookupByLibrary.simpleMessage("errorTimeout"),
        "labelOops": MessageLookupByLibrary.simpleMessage("Oops"),
        "notNow": MessageLookupByLibrary.simpleMessage("Not now"),
        "pleaseEnterAmount":
            MessageLookupByLibrary.simpleMessage("Please Enter Amount"),
        "registration": MessageLookupByLibrary.simpleMessage("REGISTRATION"),
        "titlePermissionDenied":
            MessageLookupByLibrary.simpleMessage("Permission Denied!"),
        "titleUserUnauthorized":
            MessageLookupByLibrary.simpleMessage("User unauthorized!"),
        "validErrorEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter valid email address!")
      };
}

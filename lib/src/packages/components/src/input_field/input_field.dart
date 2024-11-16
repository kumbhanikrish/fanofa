import 'package:flutter/material.dart';

export 'common_drop_down.dart';
export 'common_text_field.dart';
export 'mobile_number_field.dart';
export 'otp_field.dart';
export 'password_field.dart';
export 'search_field.dart';

abstract class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;
  final String? hintText;
  final GlobalKey<FormFieldState>? fieldKey;
  final ValueChanged<String>? onFieldSubmitted;
  final Widget? suffixIcon;

  const InputField({
    super.key,
    this.fieldKey,
    this.controller,
    this.focusNode,
    this.validator,
    this.autofillHints,
    this.textInputAction,
    this.hintText,
    this.onFieldSubmitted,
    this.suffixIcon,
  });

  @override
  InputFieldState<InputField> createState();
}

abstract class InputFieldState<S extends InputField> extends State<S> {
  late TextEditingController controller;
  final ValueNotifier<bool> isValid = ValueNotifier(false);

  @override
  void initState() {
    _initController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant S oldWidget) {
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(controllerListener);
      _initController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(controllerListener);
    super.dispose();
  }

  void _initController() {
    controller = widget.controller ?? TextEditingController();
    controller.addListener(controllerListener);
    controllerListener();
  }

  void controllerListener();
}

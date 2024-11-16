import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


const kPasswordPattern = r'^.*(?=.{8,255})((?=.*[!@#$%^&*_,]){1})(?=.*\d)((?=.*[A-Z]){1})((?=.*[a-z]){1}).*$';

class PasswordField extends InputField {
  const PasswordField({
    super.key,
    super.fieldKey,
    super.controller,
    super.focusNode,
    super.validator,
    super.autofillHints,
    super.textInputAction,
    super.hintText,
    this.onChanged,
    this.border,
    this.isValid = false,
    this.textStyle,
  });

  final void Function(String)? onChanged;
  final OutlineInputBorder? border;
  final bool? isValid;
  final TextStyle? textStyle;

  @override
  InputFieldState<InputField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends InputFieldState<PasswordField> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  void controllerListener() {
    isValid.value = RegExp(kPasswordPattern).hasMatch(controller.text.trim()) && widget.validator?.call(controller.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPasswordVisible,
      builder: (context, isPasswordVisible, child) {
        var colorScheme = Theme.of(context).colorScheme;
        return CommonTextField(
          key: widget.fieldKey,
          controller: controller,
          focusNode: widget.focusNode,
          //obscuringCharacter: "●",
          autofillHints: widget.autofillHints,
          validator: widget.validator,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !isPasswordVisible,
          textInputAction: widget.textInputAction,
          border: widget.border,
          focusBoder: widget.border,
          enabledBoder: widget.border,
          onChange: widget.onChanged,
          textStyle: widget.textStyle,
          inputFormatters: [
            LengthLimitingTextInputFormatter(64),
          ],
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: Insets.normal),
          //   child: SvgImageFromAsset(
          //     AppIcons.lock,
          //     color: widget.isValid! ? context.colorScheme.primary : null,
          //   ),
          // ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _isPasswordVisible.value = !isPasswordVisible,
                icon: SvgImageFromAsset.square(
                  isPasswordVisible ? AppIcons.eyeShow : AppIcons.eyeHide,
                  color: colorScheme.surfaceTint,
                  size: 16.67,
                ),
              ),
            ],
          ),
          hintText: widget.hintText,
        );
      },
    );
  }
}

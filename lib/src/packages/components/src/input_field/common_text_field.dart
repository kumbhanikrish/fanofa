import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../resouces/src/theme/theme.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final List<String>? autofillHints;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? labelText;
  final GlobalKey<FormFieldState>? fieldKey;
  final Widget? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final bool? obscureText;
  final String? obscuringCharacter;
  final InputBorder? enabledBoder;
  final InputBorder? focusBoder;
  final InputBorder? errorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedErrorBorder;
  final bool roundBorder;
  final bool? isDense;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final Color? filledColor;
  final ValueChanged<String>? onChange;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final bool? isValidate;
  final InputDecoration? decoration;
  final TextStyle? style;

  const CommonTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.isDense,
    this.validator,
    this.autofillHints,
    this.textInputAction,
    this.keyboardType,
    this.hintText,
    this.labelText,
    this.fieldKey,
    this.suffixIcon,
    this.minLines,
    this.maxLines,
    this.readOnly = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.obscureText = false,
    this.obscuringCharacter,
    this.enabledBoder,
    this.focusBoder,
    this.roundBorder = false,
    this.textAlign,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.onChange,
    this.prefixConstraints,
    this.suffixConstraints,
    this.border,
    this.filledColor,
    this.hintStyle,
    this.contentPadding,
    this.errorBorder,
    this.disabledBorder,
    this.focusedErrorBorder,
    this.textStyle,
    this.isValidate,
    this.labelStyle,
    this.decoration,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    var inputField = TextFormField(
  cursorColor: Theme.of(context).colorScheme.inverseSurface,
      key: fieldKey,
      onTap: onTap,
      onChanged: onChange,
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: autofillHints,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines ?? 1,
      minLines: minLines,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      onFieldSubmitted: onFieldSubmitted,
      obscuringCharacter: obscuringCharacter ?? "•",
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign ?? TextAlign.start,
      style:style?? const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF333333)),
      decoration: decoration ?? InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              fontFamily: AppTheme.kFontFamily,
              fontWeight: FontWeight.w400,
              //fontSize: 10,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
        labelText: labelText,
        labelStyle: labelStyle ??
            TextStyle(
              fontFamily: AppTheme.kFontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 08),
        /*
        constraints: BoxConstraints(
          maxHeight: 200,
          minHeight: 200,
        ),*/
        /*       contentPadding: contentPadding ??
            EdgeInsets.only(
              left: 8, bottom: 2, top: suffixIcon != null ? 10 : 10,),*/
        // hintText: hintText,
        // hintStyle: hintStyle,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixConstraints ??
            const BoxConstraints(
              maxWidth: 100,
              maxHeight: 100,
            ),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixConstraints ??
            const BoxConstraints(
              maxWidth: 200,
              maxHeight: 200,
            ),
        enabledBorder:
            enabledBoder /*??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.transparent))*/
        ,
        focusedBorder:
            focusBoder /*??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.transparent))*/
        ,
        // fillColor: (fieldKey?.currentState?.isValid == null)
        //     ? filledColor
        //     : (fieldKey!.currentState!.isValid)
        //         ? context.colorScheme.primary.withOpacity(0.2)
        //         : context.colorScheme.error.withOpacity(0.05),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        border:
            border /*??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                  color:const Color(0xFFBBBBBB),),)*/
        ,
        isDense: isDense ?? false,
        isCollapsed: true,
        errorBorder:
            errorBorder /*??
          OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.transparent))*/
        ,
        disabledBorder: disabledBorder,
        focusedErrorBorder: focusedErrorBorder,
      ),
      obscureText: obscureText ?? false,
    );

/*    if (labelText != null && labelText!.isNotEmpty) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    CommonText.bold(labelText!, size: 14),
    const Gap(4),
    inputField,
    ],
    );
    }*/

    return inputField;
  }
}
/*var inputField = Container(
      //height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFBBBBBB)),
          color: context.colorScheme.onSecondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hintText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Text(
                hintText!,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: context.colorScheme.inverseSurface),
              ),
            ),
          TextFormField(
            key: fieldKey,
            onTap: onTap,
            onChanged: onChange,
            controller: controller,
            focusNode: focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: autofillHints,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            maxLines: maxLines ?? 1,
            minLines: minLines,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            onFieldSubmitted: onFieldSubmitted,
            obscuringCharacter: obscuringCharacter ?? "•",
            textAlignVertical: TextAlignVertical.center,
            textAlign: textAlign ?? TextAlign.start,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF0F0F0F)),
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxHeight: 50,
              ),
              contentPadding: contentPadding ??
                   EdgeInsets.only(left: 8, bottom: 2,top: suffixIcon != null ? 10 :10,),
              // hintText: hintText,
              // hintStyle: hintStyle,
              suffixIcon: suffixIcon,
              suffixIconConstraints: suffixConstraints ??
                  const BoxConstraints(
                    maxWidth: 100,
                    maxHeight: 100,
                  ),
              prefixIcon: prefixIcon,
              prefixIconConstraints: prefixConstraints ??
                  const BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200,
                  ),
              enabledBorder: enabledBoder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: focusBoder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.transparent)),
              // fillColor: (fieldKey?.currentState?.isValid == null)
              //     ? filledColor
              //     : (fieldKey!.currentState!.isValid)
              //         ? context.colorScheme.primary.withOpacity(0.2)
              //         : context.colorScheme.error.withOpacity(0.05),
              fillColor: Colors.transparent,
              filled: true,
              border: border ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.transparent)),
              isDense: isDense ?? false,
              isCollapsed: true,
              errorBorder: errorBorder ??
                  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.transparent)),
              disabledBorder: disabledBorder,
              focusedErrorBorder: focusedErrorBorder,
            ),
            obscureText: obscureText ?? false,
          ),
        ],
      ),
    );*/

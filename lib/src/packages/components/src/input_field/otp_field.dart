import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../../resouces/resources.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final int length;
/*  final ValueChanged<String>? onChanged;
  final ValueSetter<String>? onCompleted;*/
  final FormFieldValidator<String>? validator;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.length,
 /*   this.onChanged,
    this.onCompleted,*/
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return  Pinput(
      controller: controller,
      length: length,
      autofocus: false,
      validator: validator,
      autofillHints: const [AutofillHints.oneTimeCode],
      pinAnimationType: PinAnimationType.scale,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: PinTheme(
        // width: size + 5,
        // height: size + 10,
        height: 47.37,
        width: 47.37,
        //  margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          //color: colorScheme.surface,
          borderRadius: ShapeBorderRadius.medium,
          border: Border.all(color: context.colorScheme.inverseSurface),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: context.colorScheme.surfaceTint,
          fontFamily: AppTheme.kFontFamily,
        ),
      ),
      focusedPinTheme: PinTheme(
        // width: size + 5,
        // height: size + 10,
        height: 47.37,
        width: 47.37,
        //  margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          //color: colorScheme.surface,
          borderRadius: ShapeBorderRadius.medium,
          border: Border.all(color: context.colorScheme.inverseSurface),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: context.colorScheme.surfaceTint,
          fontFamily: AppTheme.kFontFamily,
        ),
      ),
      submittedPinTheme: PinTheme(
        // width: size + 5,
        // height: size + 10,
        height: 47.37,
        width: 47.37,
        //  margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          //color: colorScheme.surface,
          borderRadius: ShapeBorderRadius.medium,
          border: Border.all(color: context.colorScheme.outlineVariant),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: context.colorScheme.surfaceTint,
          fontFamily: AppTheme.kFontFamily,
        ),
      ),
      errorPinTheme: PinTheme(
        // width: size + 5,
        // height: size + 10,
        height: 47.37,
        width: 47.37,
        //  margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          //color: colorScheme.surface,
          borderRadius: ShapeBorderRadius.medium,
          border: Border.all(color: context.colorScheme.error),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: context.colorScheme.surfaceTint,
          fontFamily: AppTheme.kFontFamily,
        ),
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
    );
  }


/*  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: colorScheme.surfaceTint,
      fontFamily: AppTheme.kFontFamily,
    );
    final pinTheme = PinTheme(
      // width: size + 5,
      // height: size + 10,
      height: 47.37,
      width: 47.37,
      //  margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        //color: colorScheme.surface,
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: colorScheme.inverseSurface),
      ),
      textStyle: textStyle,
    );
    return Pinput(
      validator: validator,
      controller: controller,
      autofocus: true,
      autofillHints: const [AutofillHints.oneTimeCode],
      pinAnimationType: PinAnimationType.scale,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      defaultPinTheme: pinTheme,
      followingPinTheme: pinTheme.copyBorderWith(
          border: Border.all(color: colorScheme.inverseSurface)),
      focusedPinTheme: pinTheme.copyBorderWith(
          border: Border.all(color: colorScheme.inverseSurface)),
      submittedPinTheme: pinTheme.copyBorderWith(
          border: Border.all(color: theme.colorScheme.outlineVariant)),
      errorPinTheme:
          pinTheme.copyBorderWith(border: Border.all(color: colorScheme.error)),
      length: length,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
    *//*return LayoutBuilder(
      builder: (context, constraints) {
        final size = (min(constraints.maxWidth, 400) - 80) / length;
        final pinTheme = PinTheme(
          // width: size + 5,
          // height: size + 10,
          height: 47.37,
          width: 47.37,
          //  margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            //color: colorScheme.surface,
            borderRadius: ShapeBorderRadius.normal,
            border: Border.all(color: colorScheme.inverseSurface),
          ),
          textStyle: textStyle,
        );

        return Pinput(
          validator: validator,
          controller: controller,
          autofocus: false,
         // autofillHints: const [AutofillHints.oneTimeCode],
          pinAnimationType: PinAnimationType.scale,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: pinTheme,
          followingPinTheme: pinTheme.copyBorderWith(border: Border.all(color: colorScheme.inversePrimary)),
          focusedPinTheme: pinTheme.copyBorderWith(border: Border.all(color: colorScheme.inversePrimary)),
          submittedPinTheme: pinTheme.copyBorderWith(border: Border.all(color: theme.colorScheme.inversePrimary)),
          errorPinTheme: pinTheme.copyBorderWith(border: Border.all(color: colorScheme.error)),
          length: length,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          onCompleted: onCompleted,
          enabled: true,
        );
      },
    );*//*
  }*/
}

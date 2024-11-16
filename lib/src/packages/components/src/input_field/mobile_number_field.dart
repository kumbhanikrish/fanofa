import 'package:country_picker/country_picker.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:fanofa/src/packages/components/src/widgets/text.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'input_field.dart';

class MobileNumberField extends InputField {
  final Country country;
  final ValueSetter<Country> onCountrySelected;
  final bool readOnly;

  const MobileNumberField(
      {super.key,
      super.fieldKey,
      super.controller,
      super.focusNode,
      super.validator,
      super.autofillHints,
      super.textInputAction,
      super.hintText,
      super.onFieldSubmitted,
      super.suffixIcon,
      required this.country,
      required this.onCountrySelected,
      this.readOnly = false});

  @override
  InputFieldState<MobileNumberField> createState() => _MobileNumberFieldState();
}

class _MobileNumberFieldState extends InputFieldState<MobileNumberField> {
  late Country _country;

  @override
  void initState() {
    _country = widget.country;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MobileNumberField oldWidget) {
    if (_country != widget.country) {
      _country = widget.country;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onCountrySelected(Country country) {
    widget.onCountrySelected(country);
    setState(() => _country = country);
  }

  @override
  void controllerListener() {
    isValid.value = widget.validator?.call(controller.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      controller: controller,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: widget.autofillHints,
      validator: widget.validator,
      keyboardType: TextInputType.phone,
      readOnly: widget.readOnly,
     // inputFormatters: [MobileNumberInputFormatter(_country.level)],
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        prefixIcon: CountryPicker(
            country: _country, onCountrySelected: _onCountrySelected),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}

class MobileNumberInputFormatter extends TextInputFormatter {
  final int maxLength;

  MobileNumberInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.replaceAll(" ", "").length > maxLength) return oldValue;
    if (newValue.text.length > oldValue.text.length) {
      if (int.tryParse(newValue.text.replaceAll(" ", "")) == null) {
        return oldValue;
      }
      var newText = newValue.text.replaceAll(" ", "");
      StringBuffer buffer = StringBuffer();
      for (int index = 0; index < newText.length; index++) {
        buffer.write(newText[index]);
        if (index == 2 || index == 5 || index == 7) buffer.write(" ");
      }
      return TextEditingValue(
          text: buffer.toString(),
          selection: TextSelection.collapsed(offset: buffer.length));
    } else {
      var newText = newValue.text.trim();
      return newValue.copyWith(
          text: newText.trim(),
          selection: TextSelection.collapsed(offset: newText.length));
    }
  }
}

class CountryPicker extends StatefulWidget {
  Country country;
  final ValueSetter<Country>? onCountrySelected;

  CountryPicker(
      {super.key, required this.country, required this.onCountrySelected});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Future<void> _onCountryTap() async {
    var country = showCountryPicker(
        context: context,
        moveAlongWithKeyboard: true,
        useSafeArea: true,
        showPhoneCode: true,
        useRootNavigator: true,
        onSelect: (Country value) {
          setState(
            () {
              widget.country = value;
            },
          );
          widget.onCountrySelected?.call(value);
        });

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.onCountrySelected == null ? null : _onCountryTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 12,
                bottom: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.country.flagEmoji),
                  const Gap(4),
                  IntrinsicWidth(
                    child: Container(
                      height: 24,
                      alignment: AlignmentDirectional.bottomStart,
                      child: CommonText.medium(
                        "+${widget.country.phoneCode}",
                        size: 16,
                        height: 1.3,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                  const Gap(4),
                  const SvgImageFromAsset(AppIcons.dropdown,width: 8,height: 4,)
                ],
              ),
            ),
          ),
          const Gap(4),
       /*   SizedBox(
            height: 20,
            child: VerticalDivider(
              color: colorScheme.onTertiaryContainer,
            ),
          ),*/
        ],
      ),
    );
  }
}

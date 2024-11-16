import 'package:fanofa/src/packages/components/components.dart';
import 'package:flutter/material.dart';


class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final bool readOnly;
  final Color? fillColor;

  const SearchField({
    super.key,
    this.controller,
    this.onSubmitted,
    this.hintText,
    this.readOnly = false,
    this.fillColor,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onSubmitted: onSubmitted,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: fillColor,
        hintText: hintText,
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
        suffixIconConstraints: BoxConstraints.tight(const Size.square(40)),
        suffixIcon: ActionIcon(
          onPressed: () => onSubmitted?.call(controller?.text ?? ""),
          icon: const SvgImageFromAsset.square(
            "AppIcons.search",
            color: Colors.red,
            size: 20,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'text.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;

  const CustomRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool disabled = onChanged == null;

    return InkResponse(
      onTap: disabled ? null : () => onChanged?.call(value),
      highlightColor: theme.colorScheme.primary.withOpacity(0.1),
      splashColor: Colors.transparent,
      radius: 20,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: theme.colorScheme.primary.withAlpha(disabled ? 150 : 255),
            width: value == groupValue ? 6 : 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const SizedBox.square(dimension: 20),
      ),
    );
  }
}

class CustomRadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueSetter<T>? onChanged;
  final String title;
  final bool isDense;

  const CustomRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.isDense = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const minimumDensity = VisualDensity.minimumDensity;
    final visualDensity = isDense ? const VisualDensity(horizontal: minimumDensity, vertical: minimumDensity) : VisualDensity.comfortable;
    final bool disabled = onChanged == null;

    return ListTile(
      minLeadingWidth: 24,
      horizontalTitleGap: 12,
      visualDensity: visualDensity,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: CustomRadio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      onTap: disabled ? null : () => onChanged?.call(value),
      title: CommonText.medium(title, size: 14, color: colorScheme.onBackground.withAlpha(disabled ? 200 : 255)),
    );
  }
}

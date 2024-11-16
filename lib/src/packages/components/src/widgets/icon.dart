import 'package:flutter/material.dart';

import 'image.dart';

class BackIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;

  const BackIcon({super.key, this.onPressed, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ActionIcon(
      visualDensity: VisualDensity.comfortable,
      onPressed: onPressed ?? Navigator.of(context).maybePop,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: SvgImageFromAsset.square("AppIcons.back", color: iconColor ?? IconTheme.of(context).color, size: 16),
    );
  }
}

class CloseIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const CloseIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionIcon(
      visualDensity: VisualDensity.comfortable,
      onPressed: onPressed ?? Navigator.of(context).maybePop,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      icon: SvgImageFromAsset.square("AppIcons.close", color: IconTheme.of(context).color),
    );
  }
}

class ActionIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final VisualDensity? visualDensity;
  final String? tooltip;
  final double? iconSize;

  const ActionIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.visualDensity = VisualDensity.compact,
    this.tooltip,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        visualDensity: visualDensity,
        tooltip: tooltip,
        iconSize: iconSize,
      ),
    );
  }
}

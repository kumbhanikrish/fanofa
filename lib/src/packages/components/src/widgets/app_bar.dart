import 'package:core/core.dart';
import 'package:data/data.config.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:flutter/material.dart';

import 'icon.dart';
import 'image.dart';

class RoundedAppBar extends AppBar {
  RoundedAppBar({
    super.key,
    Widget? leading,
    super.title,
    super.actions,
    super.flexibleSpace,
    super.bottom,
    super.backgroundColor,
    super.foregroundColor,
    super.iconTheme,
    super.actionsIconTheme,
    super.primary = true,
    super.excludeHeaderSemantics = false,
    super.toolbarOpacity = 1.0,
    super.bottomOpacity = 1.0,
    super.toolbarHeight,
    super.leadingWidth,
    super.toolbarTextStyle,
    super.titleTextStyle,
    super.systemOverlayStyle,
  }) : super(
          leading: leading ?? const BackIcon(),
          centerTitle: false,
          titleSpacing: 0,
          elevation: 1,
          scrolledUnderElevation: 1,
        );
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final VoidCallback? onTapBack;
  final bool backIcon;
  final bool centerTitle;
  final List<Widget>? action;
  final Color? backgroundColor;
  final Color? shadowColor;
  final double? elevation;
  final double? toolBarHeight;
  final Widget? leading;

  const CommonAppBar({
    super.key,
    this.title,
    this.onTapBack,
    this.backIcon = true,
    this.action,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.toolBarHeight,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //  primary: true,
      titleSpacing: backIcon ? 5 : 21,
      backgroundColor: backgroundColor ?? Colors.white,
      toolbarHeight: toolBarHeight,
      title: title,
      leadingWidth:backIcon? 50 :0,
      leading: backIcon
          ? InkWell(
              onTap: onTapBack ?? () => Navigator.of(context).maybePop(),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: context.colorScheme.primaryFixedDim,
                  child: const SvgImageFromAsset(
                    AppIcons.backIcon,
                    //fit: BoxFit.cover,
                    //height: 10,
                    //width: 35,
                   // fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            )
          : leading,
      centerTitle: centerTitle,
      elevation: elevation ?? 0,
      shadowColor: shadowColor ?? Colors.transparent,
      actions:action,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

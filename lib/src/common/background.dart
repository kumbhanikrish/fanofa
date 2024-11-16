import 'package:fanofa/src/packages/components/components.dart';
import 'package:flutter/material.dart';

import '../assets_path/assets_images.dart';


class CommonBackground extends StatelessWidget {
  Widget child;
  Widget? appBar;

  CommonBackground({required this.child, this.appBar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SvgImageFromAsset(
          AppImages.background,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        child,
        Positioned(
          top: 0,
          child: appBar ?? SizedBox.shrink(),
        )
      ],
    );
  }
}

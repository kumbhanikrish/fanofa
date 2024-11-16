import 'package:core/core.dart';
import 'package:fanofa/src/packages/resouces/resources.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../packages/components/components.dart';


class CommonEmptyView extends StatefulWidget {
  final String title;
  final String vectorImage;
  final bool isFromItem;

  const CommonEmptyView({
    super.key,
    this.title = "",
    this.vectorImage = "",
    this.isFromItem = false,
  });

  @override
  State<CommonEmptyView> createState() => _CommonEmptyViewState();
}

class _CommonEmptyViewState extends State<CommonEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: context.width * 0.15,
                    right: context.width * 0.15,
                    top: context.width * 0.2,
                  ),
                  child: SvgImageFromAsset(
                    widget.vectorImage,
                    fit: BoxFit.contain,
                    width: context.width,
                  ),
                ),
              ),
              const Gap(20),
              CommonText.medium(
                widget.title,
                size: 22,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Gap(20),
        const Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(
              right: kFloatingActionButtonMargin + 70,
              bottom: 30,
            ),
            child: SvgImageFromAsset.square(
              AppIcons.arrowIcons,
              size: 90,
            ),
          ),
        )
      ],
    );
  }
}

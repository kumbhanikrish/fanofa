import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../packages/components/components.dart';


class CommonDialogView extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String btnTitle;

  const CommonDialogView({Key? key, required this.title,  this.subTitle, required this.btnTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Theme(
        data: context.theme.copyWith(
          inputDecorationTheme: context.theme.inputDecorationTheme.copyWith(
            fillColor: context.colorScheme.surface,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => context.navigator.pop(),
                  icon: Icon(Icons.close, color: context.colorScheme.surfaceTint),
                ),
              ),
              ClipRect(
                  child: Icon(
                Icons.info_outline,
                size: 120,
                color: context.colorScheme.error,
              )),
              const Gap(20),
              CommonText.medium(
                title,
                size: 18,
                color: context.colorScheme.surfaceTint,
              ),
              const Gap(10),
              CommonText.regular(
                subTitle??"",
                size: 14,
                textAlign: TextAlign.center,
              ),
              const Gap(30),
              PrimaryButton(onPressed: () {}, label: btnTitle),
              TextButton(
                onPressed: () => context.navigator.pop(),
                child: const CommonText.medium(
                  "Cancel",
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

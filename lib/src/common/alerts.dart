import 'package:core/core.dart';
import 'package:fanofa/src/packages/resouces/src/theme/app_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../packages/components/components.dart';


void showSuccessMessage({required BuildContext context, required String title, required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(AlertMessage(
    title: title,
    description: content,
    backgroundColor: context.appColor.success.withOpacity(0.8),
    foregroundColor: context.colorScheme.onErrorContainer,
    duration: const Duration(seconds: 10),
  ));
}

void showErrorMessage({required BuildContext context, required String title, required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(AlertMessage(
    title: title,
    description: content,
    backgroundColor: context.colorScheme.onError,
    foregroundColor: context.colorScheme.onErrorContainer,
  ));
}

void showValidationMessage({required BuildContext context, required String title}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CommonText.medium(
        title,
        size: 14,
        maxLines: 5,
      ),
      backgroundColor: context.colorScheme.surfaceTint,
    ),
  );
}

Future<void> showErrorSheet({
  required BuildContext context,
  required String title,
  //required String content,
  required ModalButton button,
}) {
  return showGeneralDialog(
    context: context,
    routeSettings: const RouteSettings(name: "/error_dialog"),
    barrierDismissible: false,
    barrierLabel: "error_dialog",
    pageBuilder: (context, animation, secondaryAnimation) => ErrorSheet(title: title, /*content: content,*/ button: button),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
      position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0.0)).animate(animation),
      child: child,
    ),
  );
}

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  Widget? icon,
  ModalButton? positiveButton,
  ModalButton? negativeButton,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    routeSettings: const RouteSettings(name: "/app_dialog"),
    barrierDismissible: barrierDismissible,
    barrierLabel: "app_dialog",
    pageBuilder: (context, animation, secondaryAnimation) => SafeArea(
      child: AppDialog(
        title: title,
        content: content,
        icon: icon,
        positiveButton: positiveButton,
        negativeButton: negativeButton,
      ),
    ),
    transitionDuration: const Duration(milliseconds: 100),
    transitionBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

class CommonDialog extends StatelessWidget {
  final String image;
  final String title;
  final String content;
  final VoidCallback onPress;
  final VoidCallback onPress2;
  final String btnText;
  final String btnText2;

  const CommonDialog(
      {super.key,
      required this.image,
      required this.title,
      required this.content,
      required this.onPress,
      required this.btnText,
      required this.btnText2,
      required this.onPress2});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: context.width * 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 35,
          bottom: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgImageFromAsset.square(
              image,
              size: 70,
              color: context.colorScheme.primary,
            ),
            const Gap(20),
            CommonText.semiBold(
              title,
              color: context.colorScheme.primary,
              size: 20,
              textAlign: TextAlign.center,
            ),
            const Gap(8),
            CommonText(
              content,
              color: context.colorScheme.surfaceTint,
              size: 14,
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPress,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.onTertiaryContainer, side: BorderSide(color: context.colorScheme.surface)),
                    child: FittedBox(
                      child: CommonText.medium(
                        btnText,
                        size: 16,
                        color: context.colorScheme.surfaceTint,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPress2,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                    ),
                    child: FittedBox(
                      child: CommonText.medium(
                        btnText2,
                        size: 16,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

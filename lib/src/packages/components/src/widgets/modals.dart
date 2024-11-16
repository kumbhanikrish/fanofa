import 'package:core/core.dart';
import 'package:fanofa/src/packages/components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resouces/resources.dart';



class ModalButton {
  final String label;
  final VoidCallback? onPressed;

  const ModalButton({
    required this.label,
    required this.onPressed,
  });
}

class ErrorSheet extends StatelessWidget {
  final String title;
  //final String content;
  final ModalButton button;

  const ErrorSheet({
    super.key,
    required this.title,
    //required this.content,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium),
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        color: colorScheme.background,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                child: CommonText.bold(title, size: 16,color: context.colorScheme.primary,),
              ),
              /*Flexible(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CommonText.medium(
                      content,
                      size: 12,
                      textAlign: TextAlign.start,
                        color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),*/
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ErrorButton(
                  onPressed: button.onPressed ?? () => Navigator.of(context).removeRoute(ModalRoute.of(context)!),
                  label: button.label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;

  const DialogHeader({
    super.key,
    required this.title,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CommonText.semiBold(title, size: 16),
              ),
            ),
            CloseButton(onPressed: onClose),
          ],
        ),
      ),
    );
  }
}

class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final Widget? icon;
  final ModalButton? positiveButton;
  final ModalButton? negativeButton;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    this.icon,
    this.positiveButton,
    this.negativeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DialogHeader(title: title),
          if (icon != null) ...[
            const Gap(16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 84, maxHeight: 84),
              child: icon!,
            ),
          ],
          Flexible(
            child: IntrinsicHeight(
              child: Container(
                constraints: const BoxConstraints(minHeight: 84),
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: CommonText.medium(content, size: 14, textAlign: TextAlign.center),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                if (negativeButton != null)
                  Expanded(
                    child: TertiaryButton(
                      onPressed: negativeButton!.onPressed ?? () => Navigator.of(context).pop(false),
                      label: negativeButton!.label,
                    ),
                  ),
                if (positiveButton != null && negativeButton != null) const Gap(16),
                if (positiveButton != null)
                  Expanded(
                    child: PrimaryButton(
                      onPressed: positiveButton!.onPressed ?? () => Navigator.of(context).pop(true),
                      label: positiveButton!.label,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AlertModal extends StatelessWidget {
  final String title;
  final String vector;
  final ModalButton button;

  const AlertModal({
    super.key,
    required this.title,
    required this.button,
    required this.vector,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgImageFromAsset.square(vector, size: 80),
              const Gap(24),
              CommonText.semiBold(title, size: TextSize.heading, textAlign: TextAlign.center),
              const Gap(24),
              PrimaryButton(onPressed: button.onPressed ?? Navigator.of(context).maybePop, label: button.label),
            ],
          ),
        ),
      ),
    );
  }
}

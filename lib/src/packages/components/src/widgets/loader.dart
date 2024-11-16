import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'image.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: Center(
            child: Card(
              elevation: 0,
              child: SizedBox.square(
                dimension: 84,
                child: Padding(
                  padding: EdgeInsets.all(22.0),
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          )),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox.square(
        dimension: 84,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class RefreshIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const RefreshIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.onTertiaryContainer.withAlpha(150);
    return Center(
      child: Material(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: BorderSide(width: 2, color: color),
        ),
        color: Colors.transparent,
        child: IconButton(
          onPressed: onPressed,
          icon: SvgImageFromAsset.square("AppIcons.refresh", color: color),
        ),
      ),
    );
  }
}

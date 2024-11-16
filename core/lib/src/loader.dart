import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: const Dialog(
          // alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: SizedBox(
            width: 100,
            height: 100,
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              child: SizedBox.square(
                dimension: 84,
                child: Center(child: LoadingIndicator()),
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
        dimension: 24,
        child: CircularProgressIndicator(),
      ),
    );
  }
}

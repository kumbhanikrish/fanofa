import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'text.dart';

class EmptyDataView extends StatelessWidget {
  final Widget? vector;
  final String label;

  const EmptyDataView({super.key, this.vector, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (vector != null) ...[
            vector!,
            const Gap(12),
          ],
          CommonText.semiBold(label, size: 14, color: Theme.of(context).colorScheme.onTertiaryContainer, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

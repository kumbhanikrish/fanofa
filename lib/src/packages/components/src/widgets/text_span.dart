import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextSpan {
  final String text;
  final VoidCallback? onPressed;

  const LinkTextSpan({
    required this.text,
    this.onPressed,
  });
}

class LinkText extends StatelessWidget {
  final List<LinkTextSpan> listSpan;
  final TextStyle? style;
  final TextAlign? textAlign;

  const LinkText({
    super.key,
    required this.listSpan,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: colorScheme.onTertiaryContainer).merge(style);

    return Text.rich(
      TextSpan(
        children: [
          for (var span in listSpan)
            if (span.onPressed == null)
              TextSpan(text: span.text)
            else
              TextSpan(
                text: span.text,
                style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()..onTap = span.onPressed,
              )
        ],
      ),
      style: textStyle,
      textAlign: textAlign,
    );
  }
}

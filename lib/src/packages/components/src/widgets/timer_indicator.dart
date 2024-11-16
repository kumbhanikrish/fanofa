import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimerIndicator extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onCompleted;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget Function(BuildContext context, Duration total, Duration remaining, Duration elapsed)? centerBuilder;

  const TimerIndicator({
    super.key,
    required this.duration,
    this.foregroundColor,
    this.backgroundColor,
    this.onCompleted,
    this.centerBuilder,
  });

  @override
  State<TimerIndicator> createState() => _TimerIndicatorState();
}

class _TimerIndicatorState extends State<TimerIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener(_onAnimationStatusChanged);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => afterFirstLayout());
  }

  void afterFirstLayout() {
    _controller.animateTo(1.0, curve: Curves.linear, duration: widget.duration);
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onCompleted?.call();
    }
  }

  @override
  void didUpdateWidget(covariant TimerIndicator oldWidget) {
    if (widget.duration != oldWidget.duration) {
      _controller.reset();
      _controller.animateTo(1.0, curve: Curves.linear, duration: widget.duration);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      type: MaterialType.circle,
      color: Colors.transparent,
      child: SizedBox.square(
        dimension: 200,
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                foregroundPainter: _CircleLoaderPainter(
                  value: 1.0 - _controller.value,
                  foregroundColor: widget.foregroundColor ?? Theme.of(context).primaryColor,
                  backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor.withAlpha(50),
                ),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      if (widget.centerBuilder != null) {
                        var elapsed = _controller.lastElapsedDuration ?? (_controller.status == AnimationStatus.completed ? widget.duration : const Duration());
                        var remaining = widget.duration - elapsed;
                        return widget.centerBuilder!(context, widget.duration, remaining, elapsed);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CircleLoaderPainter extends CustomPainter {
  double value;
  Color backgroundColor;
  Color foregroundColor;

  _CircleLoaderPainter({
    required this.value,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    var backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;
    var foregroundPaint = Paint()
      ..color = foregroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;
    canvas.drawCircle(center, 84, backgroundPaint);
    var startAngle = -(math.pi / 2);
    var angle = (math.pi * 2) * value;
    canvas.drawArc(Rect.fromCircle(center: center, radius: 84), startAngle, angle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant _CircleLoaderPainter oldDelegate) => true;
}

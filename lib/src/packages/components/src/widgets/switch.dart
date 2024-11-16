import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? thumbColor;
  final Color? trackColor;
  final Color? disabledTrackColor;
  final double? margin;

  const CustomSwitch({
    required this.value,
    required this.onChanged,
    this.thumbColor = Colors.white,
    this.trackColor,
    this.disabledTrackColor,
    this.margin,
    super.key,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  double _startPosition = 0;
  double _currentPosition = 0;
  bool _value = false;
  bool _hasFocus = false;

  final double _width = 40;
  final double _height = 24;
  final double _size = 24;

  double get initialPosition {
    if (_value) {
      return _width - _size;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    _value = widget.value;
    _currentPosition = initialPosition;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomSwitch oldWidget) {
    _value = widget.value;
    _currentPosition = initialPosition;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: _height,
        width: _width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              margin: EdgeInsets.all(widget.margin??0),
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                color:
                    _value ? widget.trackColor ?? theme.primaryColor : widget.disabledTrackColor ?? theme.disabledColor,
                borderRadius: BorderRadius.circular(_height / 2),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: _currentPosition,
              top: 0,
              width: _size,
              height: _size,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onChanged(!_value);
                    HapticFeedback.mediumImpact();
                  });
                },
                onHorizontalDragStart: (details) {
                  setState(() {
                    _startPosition = details.localPosition.dx;
                    _hasFocus = true;
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    var position = initialPosition + details.localPosition.dx - _startPosition;
                    if (position <= 0) {
                      _currentPosition = 0;
                    } else if (position >= _width - _size) {
                      _currentPosition = _width - _size;
                    } else {
                      _currentPosition = position;
                      if (_currentPosition <= (_width - _size) / 2) {
                        _value = false;
                      } else {
                        _value = true;
                      }
                    }
                  });
                },
                onHorizontalDragEnd: (details) {
                  setState(() {
                    var value = _value;
                    _value = widget.value;
                    if (_currentPosition <= (_width - _size) / 2) {
                      value = false;
                    } else {
                      value = true;
                    }
                    _currentPosition = initialPosition;
                    _hasFocus = false;
                    if (value != widget.value) {
                      widget.onChanged(value);
                      HapticFeedback.mediumImpact();
                    }
                  });
                },
                child: Material(
                  type: MaterialType.circle,
                  color: _hasFocus ? theme.primaryColor.withAlpha(100) : Colors.transparent,
                  child: Container(
                    width: 16,
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: widget.thumbColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

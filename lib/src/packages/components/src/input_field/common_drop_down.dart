import 'dart:async';
import 'dart:math' as math;

import 'package:fanofa/src/packages/components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../resouces/resources.dart';
import '../../../resouces/src/theme/theme.dart';



class DropDownListItem<T> {
  final Widget? icon;
  final String label;
  final T value;

  const DropDownListItem({required this.label, required this.value, this.icon});
}

class CommonDropDownField<T> extends StatefulWidget {
  final Iterable<DropDownListItem<T>> items;
  final String hint;
  final String label;
  final FormFieldValidator<T>? validator;
  final ValueChanged<T>? fieldSubmitted;
  final FocusNode? focus;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final InputDecoration? decoration;

  const CommonDropDownField({
    super.key,
    required this.items,
    required this.onChanged,
    this.hint = "",
    this.validator,
    this.fieldSubmitted,
    this.focus,
    this.value,
    this.label = "",
    this.decoration,
  });

  @override
  State<CommonDropDownField<T>> createState() => _CommonDropDownFieldState<T>();
}

class _CommonDropDownFieldState<T> extends State<CommonDropDownField<T>> {
  late final FocusNode _focus;
  final _controller = TextEditingController();
  final ValueNotifier<bool> _isOptionVisible = ValueNotifier(false);
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  DropDownListItem<T>? _selectedItem;

  @override
  void initState() {
    _focus = widget.focus ?? FocusNode();
    if (widget.value != null) {
      _updateSelectedItem(widget.items.firstWhere((element) => element.value == widget.value));
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CommonDropDownField<T> oldWidget) {
    _updateSelectedItem(
      widget.value == null
          ? null
          : widget.items.firstWhere((element) => element.value == widget.value),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemSelected(DropDownListItem<T> item) {
    setState(() => _updateSelectedItem(item));
    _key.currentState?.validate();
    widget.onChanged?.call(item.value);
  }

  void _updateSelectedItem(DropDownListItem<T>? value) {
    _selectedItem = value;
    Timer.run(() => _controller.text = value?.label ?? "");
  }

  Future<void> _showOptions() async {
    var renderObject = context.findRenderObject();
    if (renderObject is! RenderBox) return;
    var rect = renderObject.localToGlobal(Offset.zero) & renderObject.size;

    _isOptionVisible.value = true;
    var item = await showGeneralDialog<DropDownListItem<T>>(
      context: context,
      barrierDismissible: true,
      barrierLabel: "drop_down_option",
      barrierColor: Colors.black12,
      pageBuilder: (context, animation, secondaryAnimation) =>
          _DropDownOptionsView(items: widget.items),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        var mediaQuery = MediaQuery.of(context);
        final bottomSpacing = math.max(16.0, mediaQuery.padding.bottom);
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              top: math.min(rect.bottomLeft.dy, mediaQuery.size.height - 280),
              left: rect.bottomLeft.dx,
              right: mediaQuery.size.width - rect.bottomRight.dx,
              bottom: bottomSpacing + 8,
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: animation.value,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 280),
                  child: child,
                ),
              ),
            ),
          ],
        );
      },
    );
    _isOptionVisible.value = false;
    if (item != null) _onItemSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /*if (widget.label.isNotEmpty) ...[
          CommonText.medium(widget.label, size: 14),
          const Gap(4),
        ],*/
        CommonTextField(
          key: _key,
          controller: _controller,
          readOnly: true,
          focusNode: _focus,
          onTap: widget.onChanged == null ? null : _showOptions,
        //  autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_) => widget.validator?.call(widget.value),
          decoration: (widget.decoration ?? const InputDecoration()).copyWith(
            hintText: widget.hint,
            prefixIcon: _selectedItem?.icon == null
                ? null
                : Padding(padding: const EdgeInsets.all(12), child: _selectedItem?.icon),
            prefixIconConstraints: const BoxConstraints(minWidth: 24),
            suffixIconConstraints: const BoxConstraints(minWidth: 24),
            suffixIcon: ValueListenableBuilder<bool>(
              valueListenable: _isOptionVisible,
              builder: (context, isVisible, child) => ActionIcon(
                onPressed: widget.onChanged == null ? null : _showOptions,
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  transform: Matrix4.rotationZ(isVisible ? math.pi : 0),
                  transformAlignment: Alignment.center,
                  child: SvgImageFromAsset.square(
                    "AppIcons.dropDown2",
                    color: colorScheme.onSurface,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: AppTheme.kFontFamily,
            color: Color(0xFF000000),
          ),
        ),
      ],
    );
  }
}

class _DropDownOptionsView<T> extends StatefulWidget {
  final Iterable<DropDownListItem<T>> items;

  const _DropDownOptionsView({required this.items});

  @override
  State<_DropDownOptionsView<T>> createState() => _DropDownOptionsViewState<T>();
}

class _DropDownOptionsViewState<T> extends State<_DropDownOptionsView<T>> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(top: 8),
      elevation: 4,
      shadowColor: colorScheme.surface.withAlpha(150),
      color: colorScheme.background,
      shape: const RoundedRectangleBorder(borderRadius: ShapeBorderRadius.small),
      clipBehavior: Clip.hardEdge,
      child: Builder(builder: (context) {
        /*if (widget.items.isEmpty) {
          return const SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.all(32),
              child: SvgImageFromAsset.square(VectorImages.emptyData, size: 64),
            ),
          );
        }*/
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(padding: const EdgeInsets.symmetric(vertical: 8)),
          child: PrimaryScrollController(
            controller: _scrollController,
            child: Scrollbar(
              child: CustomScrollView(
                shrinkWrap: true,
                scrollBehavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  overscroll: false,
                  physics: const ClampingScrollPhysics(),
                  platform: Theme.of(context).platform,
                ),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = widget.items.elementAt(index);
                          return ListTile(
                            dense: true,
                            horizontalTitleGap: 0,
                            leading: item.icon,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            title: CommonText.medium(
                              item.label,
                              size: 14,
                              color: colorScheme.secondary,
                            ),
                            onTap: () => Navigator.of(context).pop(item),
                          );
                        },
                        childCount: widget.items.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

part of 'd_input.dart';

class DInputDropdown<T> extends StatefulWidget {
  const DInputDropdown({
    super.key,
    required this.dropdownSpec,
    this.titleSpec,
    this.boxSpec = const BoxSpec(),
    this.prefixIcon = const IconSpec(),
    this.suffixIcon = const IconSpec(),
    this.leftChildren,
    this.rightChildren,
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
  });

  final DropdownSpec dropdownSpec;

  final TitleSpec? titleSpec;

  final BoxSpec boxSpec;

  /// Icon on left
  final IconSpec prefixIcon;

  /// Icon on right
  final IconSpec suffixIcon;

  /// add widget after prefix
  final List<Widget>? leftChildren;

  /// add widget before suffix
  final List<Widget>? rightChildren;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  @override
  State<DInputDropdown<T>> createState() => _DInputDropdownState<T>();
}

class _DInputDropdownState<T> extends State<DInputDropdown<T>> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.dropdownSpec.focusNode?.hasFocus) return;
    listenFocus.value = widget.dropdownSpec.focusNode?.hasFocus ?? false;
  }

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode?.hasFocus) return;
    listenFocus.value = localFocusNode?.hasFocus ?? false;
  }

  @override
  void initState() {
    if (widget.dropdownSpec.focusNode != null) {
      widget.dropdownSpec.focusNode?.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode?.addListener(_listenLocalFocusNode);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.dropdownSpec.focusNode != null) {
      widget.dropdownSpec.focusNode?.removeListener(_listenParentFocusNode);
    } else {
      localFocusNode?.removeListener(_listenLocalFocusNode);
      localFocusNode?.dispose();
    }
    listenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: widget.crossAxisAlignmentTitle,
      children: [
        if (widget.titleSpec != null) widget.titleSpec!,
        ValueListenableBuilder<bool>(
          valueListenable: listenFocus,
          builder: (context, isFocus, child) {
            final modifiedBoxSpec = widget.boxSpec.render(context);
            return Padding(
              padding: modifiedBoxSpec.margin,
              child: Material(
                shape: isFocus
                    ? modifiedBoxSpec.focusedShapeBorder
                    : modifiedBoxSpec.shapeBorder,
                color: isFocus
                    ? modifiedBoxSpec.focusedColor
                    : modifiedBoxSpec.color,
                child: child,
              ),
            );
          },
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignmentBox,
            children: [
              widget.prefixIcon.build(context),
              if (widget.leftChildren != null) ...widget.leftChildren!,
              Expanded(
                child: widget.dropdownSpec.build(context, localFocusNode),
              ),
              if (widget.rightChildren != null) ...widget.rightChildren!,
              widget.suffixIcon.build(context),
            ],
          ),
        ),
      ],
    );
  }
}

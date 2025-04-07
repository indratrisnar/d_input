part of 'd_input.dart';

enum InputTimeComposition { field, picker }

class DInputTime extends StatefulWidget {
  const DInputTime({
    super.key,
    required this.timePicked,
    this.initialTime,
    this.composition = (
      InputDateComposition.field,
      InputDateComposition.picker,
    ),
    this.compositionVisibility = (true, true),
    this.inputSpec = const InputSpec(),
    this.boxSpec = const BoxSpec(),
    this.titleSpec,
    this.pickerIcon = const IconSpec(
      icon: Icons.access_time,
    ),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
  });

  /// default: now
  final TimeOfDay? initialTime;

  final void Function(TimeOfDay? time) timePicked;

  /// default:
  ///
  /// ```
  /// (InputDateComposition.field, InputDateComposition.picker)
  /// ```
  final (InputDateComposition, InputDateComposition) composition;

  /// default: (true, true, true, true)
  final (bool, bool) compositionVisibility;

  /// Icon for time picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.access_time)
  /// ```
  final IconSpec pickerIcon;

  final TitleSpec? titleSpec;

  final BoxSpec boxSpec;

  final InputSpec inputSpec;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  @override
  State<DInputTime> createState() => _DInputTimeState();
}

class _DInputTimeState extends State<DInputTime> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;

  void pickTime() async {
    final now = TimeOfDay.now();
    final localInitialTime = widget.initialTime ?? now;

    final result = await showTimePicker(
      context: context,
      initialTime: localInitialTime,
    );

    if (result != null) {
      if (mounted) widget.inputSpec.controller?.text = result.format(context);
    }

    widget.timePicked(result);
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputSpec.focusNode?.hasFocus) return;
    listenFocus.value = widget.inputSpec.focusNode?.hasFocus ?? false;
  }

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode?.hasFocus) return;
    listenFocus.value = localFocusNode?.hasFocus ?? false;
  }

  @override
  void initState() {
    if (widget.inputSpec.focusNode != null) {
      widget.inputSpec.focusNode?.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode?.addListener(_listenLocalFocusNode);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.inputSpec.focusNode != null) {
      widget.inputSpec.focusNode?.removeListener(_listenParentFocusNode);
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
              buildComposition(
                  widget.composition.$1, widget.compositionVisibility.$1),
              buildComposition(
                  widget.composition.$2, widget.compositionVisibility.$2),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildComposition(InputDateComposition? composition, bool visible) {
    if (!visible) return const SizedBox();
    return switch (composition) {
      InputDateComposition.field => Expanded(
          child: widget.inputSpec.build(localFocusNode),
        ),
      InputDateComposition.picker =>
        widget.pickerIcon.copyWith(onTap: pickTime).build(context),
      _ => const SizedBox(),
    };
  }
}

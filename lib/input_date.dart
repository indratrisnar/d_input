part of 'd_input.dart';

enum InputDateComposition { field, picker }

class DInputDate extends StatefulWidget {
  const DInputDate({
    super.key,
    required this.datePicked,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.dateFormat,
    this.composition = (
      InputDateComposition.field,
      InputDateComposition.picker,
    ),
    this.compositionVisibility = (true, true),
    this.titleSpec,
    this.boxSpec = const BoxSpec(),
    this.inputSpec = const InputSpec(),
    this.pickerIcon = const IconSpec(
      icon: Icons.event,
    ),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
  });

  /// default: now
  final DateTime? initialDate;

  /// default: now - 30 days
  final DateTime? firstDate;

  /// default: now + 30 days
  final DateTime? lastDate;

  /// default: DateFormat('EEEE, d MMMM yyyy')
  final DateFormat? dateFormat;

  final void Function(DateTime? date) datePicked;

  /// default:
  ///
  /// ```
  /// (InputDateComposition.field, InputDateComposition.picker)
  /// ```
  final (InputDateComposition, InputDateComposition) composition;

  /// default: (true, true, true, true)
  final (bool, bool) compositionVisibility;

  /// Icon for date picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.event)
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
  State<DInputDate> createState() => _DInputDateState();
}

class _DInputDateState extends State<DInputDate> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;
  late DateFormat localDateFormat;

  void pickDate() async {
    final now = DateTime.now();
    final localInitialDate = widget.initialDate ?? now;
    final localFirstDate =
        widget.firstDate ?? now.subtract(const Duration(days: 30));
    final localLastDate = widget.lastDate ?? now.add(const Duration(days: 30));

    final result = await showDatePicker(
      context: context,
      initialDate: localInitialDate,
      firstDate: localFirstDate,
      lastDate: localLastDate,
    );

    if (result != null) {
      widget.inputSpec.controller?.text = localDateFormat.format(result);
    }

    widget.datePicked(result);
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
    localDateFormat = widget.dateFormat ?? DateFormat('EEEE, d MMMM yyyy');
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
        widget.pickerIcon.copyWith(onTap: pickDate).build(context),
      _ => const SizedBox(),
    };
  }
}

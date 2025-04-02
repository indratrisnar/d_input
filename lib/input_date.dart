part of 'd_input.dart';

enum InputDateComposition { field, picker }

class DInputDate extends StatefulWidget {
  const DInputDate({
    super.key,
    required this.controller,
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
    this.enabled = true,
    this.noBoxBorder = false,
    this.boxBorderRadius = const BorderRadius.all(Radius.circular(20)),
    this.boxColor,
    this.boxBorder,
    this.shapeBoxBorder,
    this.focusedBoxColor,
    this.focusedBoxBorder,
    this.focusedShapeBoxBorder,
    this.inputPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    this.inputMargin = const EdgeInsets.all(0),
    this.inputStyle,
    this.inputBackgroundColor,
    this.inputRadius = 4,
    this.inputBorderSide = BorderSide.none,
    this.inputFocusNode,
    this.inputOnChanged,
    this.inputOnFieldSubmitted,
    this.inputOnTap,
    this.hint = 'Choose Date',
    this.hintStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey,
    ),
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.pickerIcon = const IconSpec(
      icon: Icons.event,
    ),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.minLine = 1,
    this.maxLine = 1,
    this.obscureChar = '●',
    this.obscure = false,
  });

  /// controll input
  final TextEditingController controller;

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

  /// default: true
  final bool enabled;

  /// default: false
  final bool noBoxBorder;

  /// radius for all corner (box wrapper)
  ///
  /// default:
  ///
  /// `const BorderRadius.all(Radius.circular(20))`
  final BorderRadius boxBorderRadius;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? boxColor;

  /// styling for box border,
  ///
  /// will prioritize shapeBoxborder, if it's set
  ///
  /// default:
  /// ```dart
  /// const BorderSide(
  ///   color: Colors.grey,
  ///   width: 1,
  ///   strokeAlign: BorderSide.strokeAlignOutside,
  /// ),
  /// ```
  final BorderSide? boxBorder;

  /// default: RoundedRectangleBorder
  final ShapeBorder? shapeBoxBorder;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? focusedBoxColor;

  /// styling for box border
  ///
  /// ```dart
  /// BorderSide(
  ///   color: Theme.of(context).primaryColor,
  ///   width: 2,
  ///   strokeAlign: BorderSide.strokeAlignOutside,
  /// ),
  /// ```
  final BorderSide? focusedBoxBorder;

  /// default: RoundedRectangleBorder
  final ShapeBorder? focusedShapeBoxBorder;

  /// contentPadding inside InputDecoration
  final EdgeInsetsGeometry inputPadding;

  /// space to out, from TextFormField (input)
  final EdgeInsetsGeometry inputMargin;

  /// style input text
  final TextStyle? inputStyle;

  /// background color for TextFormField (input)
  final Color? inputBackgroundColor;

  /// radius for TextFormField (input)
  final double inputRadius;

  /// border style inside InputDecoration
  final BorderSide inputBorderSide;

  /// when user tap TextFormField (input)
  final void Function()? inputOnTap;

  /// listen changes from TextFormField (input)
  final void Function(String value)? inputOnChanged;

  /// when user submit input
  final void Function(String value)? inputOnFieldSubmitted;

  /// handle focus
  final FocusNode? inputFocusNode;

  /// hint TextFormField
  /// default: Choose Image
  final String hint;

  /// styling hint text
  final TextStyle hintStyle;

  /// show text title above box input
  final String? title;

  /// styling `title`
  final TextStyle titleStyle;

  /// give space between title and box input
  final double titleGap;

  /// for text area, combine with `maxLine`
  final int minLine;

  /// for text area, combine with `minLine`
  final int maxLine;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  ///```dart
  /// ●, •, ♦,
  ///```
  final String obscureChar;

  /// hide char or not
  final bool obscure;

  @override
  State<DInputDate> createState() => _DInputDateState();
}

class _DInputDateState extends State<DInputDate> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;
  late DateFormat localDateFormat;

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode!.hasFocus) return;
    listenFocus.value = localFocusNode!.hasFocus;
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputFocusNode!.hasFocus) return;
    listenFocus.value = widget.inputFocusNode!.hasFocus;
  }

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
      widget.controller.text = localDateFormat.format(result);
    }

    widget.datePicked(result);
  }

  @override
  void initState() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode!.addListener(_listenLocalFocusNode);
    }
    localDateFormat = widget.dateFormat ?? DateFormat('EEEE, d MMMM yyyy');
    super.initState();
  }

  @override
  void dispose() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.removeListener(_listenParentFocusNode);
    } else {
      localFocusNode!.removeListener(_listenLocalFocusNode);
      localFocusNode!.dispose();
    }
    listenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // setup box
    final localBoxBorderRadius = widget.boxBorderRadius;

    final localBoxColor = widget.boxColor ?? Colors.grey.shade100;
    final localBoxBorder = widget.boxBorder ??
        const BorderSide(
          color: Colors.grey,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        );
    final localShapeBoxBorder = widget.shapeBoxBorder ??
        RoundedRectangleBorder(
          borderRadius: localBoxBorderRadius,
          side: widget.noBoxBorder ? BorderSide.none : localBoxBorder,
        );

    final localFocusedBoxColor = widget.focusedBoxColor ?? localBoxColor;
    final localFocusedBoxBorder = widget.focusedBoxBorder ??
        BorderSide(
          color: primaryColor,
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        );
    final localFocusedShapeBoxBorder = widget.focusedShapeBoxBorder ??
        RoundedRectangleBorder(
          borderRadius: localBoxBorderRadius,
          side: widget.noBoxBorder ? BorderSide.none : localFocusedBoxBorder,
        );

    return Column(
      crossAxisAlignment: widget.crossAxisAlignmentTitle,
      children: [
        if (widget.title != null)
          Padding(
            padding: EdgeInsets.only(bottom: widget.titleGap),
            child: Text(
              widget.title!,
              style: widget.titleStyle,
            ),
          ),
        ValueListenableBuilder<bool>(
          valueListenable: listenFocus,
          builder: (context, isFocus, child) {
            final color = isFocus ? localFocusedBoxColor : localBoxColor;
            final shape =
                isFocus ? localFocusedShapeBoxBorder : localShapeBoxBorder;
            return Material(
              shape: shape,
              color: color,
              child: child,
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
      InputDateComposition.field => buildInputField(),
      InputDateComposition.picker =>
        widget.pickerIcon.copyWith(onTap: pickDate).build(context),
      _ => const SizedBox(),
    };
  }

  Expanded buildInputField() {
    // setup input
    final localInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.inputRadius),
      borderSide: widget.inputBorderSide,
    );
    return Expanded(
      child: Padding(
        padding: widget.inputMargin,
        child: TextFormField(
          controller: widget.controller,
          style: widget.inputStyle,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          onTap: widget.inputOnTap,
          onChanged: widget.inputOnChanged,
          onFieldSubmitted: widget.inputOnFieldSubmitted,
          focusNode: widget.inputFocusNode ?? localFocusNode,
          obscureText: widget.obscure,
          obscuringCharacter: widget.obscureChar,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.hintStyle,
            filled: widget.inputBackgroundColor != null,
            fillColor: widget.inputBackgroundColor,
            isDense: true,
            contentPadding: widget.inputPadding,
            border: localInputBorder,
            errorBorder: localInputBorder,
            enabledBorder: localInputBorder,
            focusedBorder: localInputBorder,
            disabledBorder: localInputBorder,
            focusedErrorBorder: localInputBorder,
          ),
          enabled: widget.enabled,
        ),
      ),
    );
  }
}

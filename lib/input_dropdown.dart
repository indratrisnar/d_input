part of 'd_input.dart';

class DInputDropdown<T> extends StatefulWidget {
  const DInputDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.inputOnChanged,
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
    this.inputStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.inputBackgroundColor,
    this.inputRadius = 4,
    this.inputBorderSide = BorderSide.none,
    this.inputFocusNode,
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.prefixIcon = const IconSpec(),
    this.suffixIcon = const IconSpec(),
    this.leftChildren,
    this.rightChildren,
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.itemHeight = 48,
    this.menuMaxHeight,
    this.icon = const SizedBox(),
    this.dropdownColor,
  });

  /// current active value
  final T value;

  /// list of dropdown
  final List<DropdownMenuItem<T>> items;

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
  final TextStyle inputStyle;

  /// background color for TextFormField (input)
  final Color? inputBackgroundColor;

  /// radius for TextFormField (input)
  final double inputRadius;

  /// border style inside InputDecoration
  final BorderSide inputBorderSide;

  /// handle focus
  final FocusNode? inputFocusNode;

  /// listen changes from TextFormField (input)
  final void Function(T? value) inputOnChanged;

  /// show text title above box input
  final String? title;

  /// styling `title`
  final TextStyle titleStyle;

  /// give space between title and box input
  final double titleGap;

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

  /// height for item dropdown child
  ///
  /// minimum: 48
  final double itemHeight;

  /// max height of box dropdown list
  final double? menuMaxHeight;

  /// icon on right dropdwon
  ///
  /// prefer Icon or ImageIcon Widget
  final Widget icon;

  /// background color for dropdown
  ///
  /// default: Theme.of(context).colorScheme.surfaceContainer
  final Color? dropdownColor;

  @override
  State<DInputDropdown<T>> createState() => _DInputDropdownState<T>();
}

class _DInputDropdownState<T> extends State<DInputDropdown<T>> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode!.hasFocus) return;
    listenFocus.value = localFocusNode!.hasFocus;
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputFocusNode!.hasFocus) return;
    listenFocus.value = widget.inputFocusNode!.hasFocus;
  }

  @override
  void initState() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode!.addListener(_listenLocalFocusNode);
    }
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

    // setup input
    final localInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.inputRadius),
      borderSide: widget.inputBorderSide,
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
              widget.prefixIcon.build(context),
              if (widget.leftChildren != null) ...widget.leftChildren!,
              Expanded(
                child: Padding(
                  padding: widget.inputMargin,
                  child: DropdownButtonFormField<T>(
                    value: widget.value,
                    items: widget.items,
                    style: widget.inputStyle,
                    onChanged: widget.inputOnChanged,
                    borderRadius: widget.boxBorderRadius,
                    itemHeight: widget.itemHeight,
                    menuMaxHeight: widget.menuMaxHeight,
                    icon: widget.icon,
                    focusNode: widget.inputFocusNode ?? localFocusNode,
                    dropdownColor: widget.dropdownColor ??
                        Theme.of(context).colorScheme.surfaceContainer,
                    decoration: InputDecoration(
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
                  ),
                ),
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

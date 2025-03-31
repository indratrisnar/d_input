part of 'd_input.dart';

class DInputDropdown<T> extends StatefulWidget {
  const DInputDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.inputOnChanged,
    this.noBoxBorder = false,
    this.boxRadius = 20,
    this.boxColor,
    this.boxBorder = const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    this.focusedBoxColor,
    this.focusedBoxBorder = const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
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
  /// default: 20
  final double boxRadius;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? boxColor;

  /// styling for box border
  ///
  /// default:
  /// ```dart
  /// const Border.fromBorderSide(
  ///   BorderSide(
  ///     color: Colors.grey,
  ///     width: 1,
  ///     strokeAlign: BorderSide.strokeAlignOutside,
  ///   ),
  /// )
  /// ```
  final BoxBorder? boxBorder;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? focusedBoxColor;

  /// styling for box border
  ///
  /// ```dart
  /// Border.fromBorderSide(
  ///   BorderSide(
  ///     color: Theme.of(context).primaryColor,
  ///     width: 2,
  ///     strokeAlign: BorderSide.strokeAlignOutside,
  ///   ),
  /// )
  /// ```
  final BoxBorder? focusedBoxBorder;

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
  late final FocusNode localFocusNode;

  @override
  void initState() {
    localFocusNode = widget.inputFocusNode ?? FocusNode();
    localFocusNode.addListener(() {
      listenFocus.value = localFocusNode.hasFocus;
      // log('.........................');
      // log(widget.hint.toString());
      // log('local focus node: ${localFocusNode.hasFocus}');
      // log('.........................');
    });
    super.initState();
  }

  @override
  void dispose() {
    listenFocus.dispose();
    localFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // setup box
    final localBoxColor = widget.boxColor ?? Colors.grey.shade100;
    final localBoxBorder = widget.boxBorder ??
        const Border.fromBorderSide(
          BorderSide(
            color: Colors.grey,
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        );
    final localFocusedBoxColor = widget.focusedBoxColor ?? localBoxColor;
    final localFocusedBoxBorder = widget.focusedBoxBorder ??
        Border.fromBorderSide(
          BorderSide(
            color: primaryColor,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
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
            final border = isFocus ? localFocusedBoxBorder : localBoxBorder;
            return DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(widget.boxRadius),
                border: widget.noBoxBorder ? null : border,
              ),
              child: child,
            );
          },
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignmentBox,
            children: [
              widget.prefixIcon.build(context, widget.boxRadius),
              if (widget.leftChildren != null) ...widget.leftChildren!,
              Expanded(
                child: Padding(
                  padding: widget.inputMargin,
                  child: DropdownButtonFormField<T>(
                    value: widget.value,
                    items: widget.items,
                    style: widget.inputStyle,
                    onChanged: widget.inputOnChanged,
                    borderRadius: BorderRadius.circular(widget.boxRadius),
                    itemHeight: widget.itemHeight,
                    menuMaxHeight: widget.menuMaxHeight,
                    icon: widget.icon,
                    focusNode: localFocusNode,
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
              widget.suffixIcon.build(context, widget.boxRadius),
            ],
          ),
        ),
      ],
    );
  }
}

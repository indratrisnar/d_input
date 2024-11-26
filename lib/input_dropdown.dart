part of 'd_input.dart';

class DInputDropdown<T> extends StatefulWidget {
  const DInputDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.inputOnChanged,
    this.boxRadius = 20,
    this.focusedBoxRadius = 20,
    this.boxBorder = const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    this.focusedBoxBorder = const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    ),
    this.boxColor,
    this.focusedBoxColor,
    this.noBoxBorder = false,
    this.inputPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    this.inputMargin = const EdgeInsets.all(0),
    this.inputStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.inputBackgroundColor,
    this.inputRadius = 4,
    this.inputBorderSide = BorderSide.none,
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.prefixIcon = const IconSpec(),
    this.suffixIcon = const IconSpec(),
    this.itemHeight = 48,
    this.menuMaxHeight,
    this.icon = const SizedBox(),
    this.dropdownColor,
    this.leftChildren,
    this.rightChildren,
  });

  /// current active value
  final T value;

  /// list of dropdown
  final List<DropdownMenuItem<T>> items;

  /// radius for all corner (box wrapper)
  ///
  /// default: 20
  final double boxRadius;

  /// radius for all corner (box wrapper)
  ///
  /// default: 20
  final double focusedBoxRadius;

  /// styling for box border
  ///
  /// default:
  /// ```dart
  /// const Border.fromBorderSide(
  ///   BorderSide(
  ///     color: Colors.grey,
  ///     width: 1,
  ///   ),
  /// )
  /// ```
  final BoxBorder boxBorder;

  /// styling for box border
  ///
  /// ```dart
  /// const Border.fromBorderSide(
  ///   BorderSide(
  ///     color: Colors.grey,
  ///     width: 2,
  ///   ),
  /// )
  /// ```
  final BoxBorder focusedBoxBorder;

  /// background color
  ///
  /// default: Theme.of(context).colorScheme.surfaceContainer
  final Color? boxColor;

  /// background color
  ///
  /// default: Theme.of(context).colorScheme.surfaceContainer
  final Color? focusedBoxColor;

  /// default: false
  final bool noBoxBorder;

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

  /// listen changes from TextFormField (input)
  final void Function(T? value) inputOnChanged;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

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

  /// add widget after prefix
  final List<Widget>? leftChildren;

  /// add widget before suffix
  final List<Widget>? rightChildren;

  @override
  State<DInputDropdown<T>> createState() => _DInputDropdownState<T>();
}

class _DInputDropdownState<T> extends State<DInputDropdown<T>> {
  final listenFocus = ValueNotifier(false);

  @override
  void dispose() {
    listenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.inputRadius),
      borderSide: widget.inputBorderSide,
    );
    final defaultBoxColor = Theme.of(context).colorScheme.surfaceContainer;

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
        ListenableBuilder(
          listenable: listenFocus,
          builder: (context, child) {
            bool isFocus = listenFocus.value;
            return DecoratedBox(
              decoration: BoxDecoration(
                color: isFocus
                    ? widget.focusedBoxColor ??
                        (widget.boxColor ?? defaultBoxColor)
                    : widget.boxColor ?? defaultBoxColor,
                borderRadius: BorderRadius.circular(
                  isFocus ? widget.focusedBoxRadius : widget.boxRadius,
                ),
                border: widget.noBoxBorder
                    ? null
                    : isFocus
                        ? widget.focusedBoxBorder
                        : widget.boxBorder,
              ),
              child: Row(
                crossAxisAlignment: widget.crossAxisAlignmentBox,
                children: [
                  widget.prefixIcon.build(context, widget.boxRadius),
                  if (widget.leftChildren != null) ...widget.leftChildren!,
                  Expanded(
                    child: Padding(
                      padding: widget.inputMargin,
                      child: Focus(
                        onFocusChange: (value) {
                          listenFocus.value = value;
                        },
                        child: DropdownButtonFormField<T>(
                          value: widget.value,
                          items: widget.items,
                          style: widget.inputStyle,
                          onChanged: widget.inputOnChanged,
                          borderRadius: BorderRadius.circular(widget.boxRadius),
                          itemHeight: widget.itemHeight,
                          menuMaxHeight: widget.menuMaxHeight,
                          icon: widget.icon,
                          dropdownColor: widget.dropdownColor ??
                              Theme.of(context).colorScheme.surfaceContainer,
                          decoration: InputDecoration(
                            filled: widget.inputBackgroundColor != null,
                            fillColor: widget.inputBackgroundColor,
                            isDense: true,
                            contentPadding: widget.inputPadding,
                            border: inputBorder,
                            errorBorder: inputBorder,
                            enabledBorder: inputBorder,
                            focusedBorder: inputBorder,
                            disabledBorder: inputBorder,
                            focusedErrorBorder: inputBorder,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.rightChildren != null) ...widget.rightChildren!,
                  widget.suffixIcon.build(context, widget.boxRadius),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

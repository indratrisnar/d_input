part of 'd_input.dart';

class DInputMix extends StatefulWidget {
  const DInputMix({
    super.key,
    this.controller,
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
    this.inputStyle,
    this.inputBackgroundColor,
    this.inputRadius = 4,
    this.inputBorderSide = BorderSide.none,
    this.inputFocusNode,
    this.inputOnChanged,
    this.inputOnFieldSubmitted,
    this.inputOnTap,
    this.hint,
    this.hintStyle = const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.minLine = 1,
    this.maxLine = 1,
    this.obscureChar = '●',
    this.obscure = false,
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.prefixIcon = const IconSpec(),
    this.suffixIcon = const IconSpec(),
    this.enabled,
    this.leftChildren,
    this.rightChildren,
    this.keyboardType,
    this.keyboardAppearance,
  });

  /// controll input
  final TextEditingController? controller;

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
  final String? hint;

  /// styling hint text
  final TextStyle hintStyle;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  /// for text area, combine with `maxLine`
  final int minLine;

  /// for text area, combine with `minLine`
  final int maxLine;

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

  ///```dart
  /// ●, •, ♦,
  ///```
  final String obscureChar;

  /// hide char or not
  final bool obscure;

  /// default: true
  final bool? enabled;

  /// add widget after prefix
  final List<Widget>? leftChildren;

  /// add widget before suffix
  final List<Widget>? rightChildren;

  final TextInputType? keyboardType;

  final Brightness? keyboardAppearance;

  @override
  State<DInputMix> createState() => _DInputMixState();
}

class _DInputMixState extends State<DInputMix> {
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
                        child: TextFormField(
                          controller: widget.controller,
                          style: widget.inputStyle,
                          minLines: widget.minLine,
                          maxLines: widget.maxLine,
                          onTap: widget.inputOnTap,
                          onChanged: widget.inputOnChanged,
                          onFieldSubmitted: widget.inputOnFieldSubmitted,
                          focusNode: widget.inputFocusNode,
                          obscureText: widget.obscure,
                          obscuringCharacter: widget.obscureChar,
                          keyboardType: widget.keyboardType,
                          keyboardAppearance: widget.keyboardAppearance,
                          decoration: InputDecoration(
                            hintText: widget.hint,
                            hintStyle: widget.hintStyle,
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
                          enabled: widget.enabled,
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

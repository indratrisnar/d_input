part of 'd_input.dart';

class DInputMix extends StatelessWidget {
  const DInputMix({
    super.key,
    this.controller,
    this.boxRadius = 20,
    this.boxBorder,
    this.boxColor,
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
  });

  /// controll input
  final TextEditingController? controller;

  /// radius for all corner (box wrapper)
  ///
  /// default: 20
  final double boxRadius;

  /// styling for box border
  ///
  /// default:
  /// ```dart
  /// Border.all(
  ///   color: Theme.of(context).primaryColor,
  ///   width: 2,
  /// )
  /// ```
  final BoxBorder? boxBorder;

  /// background color
  ///
  /// default: Theme.of(context).colorScheme.surfaceContainer
  final Color? boxColor;

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

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputRadius),
      borderSide: inputBorderSide,
    );
    final newBoxBorder = boxBorder ??
        Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        );
    return Column(
      crossAxisAlignment: crossAxisAlignmentTitle,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: titleGap),
            child: Text(
              title!,
              style: titleStyle,
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: boxColor ?? Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(boxRadius),
            border: newBoxBorder,
          ),
          child: Row(
            crossAxisAlignment: crossAxisAlignmentBox,
            children: [
              prefixIcon.build(context, boxRadius),
              Expanded(
                child: Padding(
                  padding: inputMargin,
                  child: TextFormField(
                    controller: controller,
                    style: inputStyle,
                    minLines: minLine,
                    maxLines: maxLine,
                    onTap: inputOnTap,
                    onChanged: inputOnChanged,
                    onFieldSubmitted: inputOnFieldSubmitted,
                    focusNode: inputFocusNode,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: hintStyle,
                      filled: inputBackgroundColor != null,
                      fillColor: inputBackgroundColor,
                      isDense: true,
                      contentPadding: inputPadding,
                      border: inputBorder,
                      errorBorder: inputBorder,
                      enabledBorder: inputBorder,
                      focusedBorder: inputBorder,
                      disabledBorder: inputBorder,
                      focusedErrorBorder: inputBorder,
                    ),
                    enabled: enabled,
                  ),
                ),
              ),
              suffixIcon.build(context, boxRadius),
            ],
          ),
        ),
      ],
    );
  }
}

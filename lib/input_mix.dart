part of 'd_input.dart';

class DInputMix extends StatelessWidget {
  const DInputMix({
    super.key,
    required this.controller,
    this.boxRadius = 20,
    this.boxBorder,
    this.boxColor = Colors.white,
    this.inputPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 14,
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
    this.crossAxisAlignment = CrossAxisAlignment.start,
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
  });

  final TextEditingController controller;
  final double boxRadius;
  final BoxBorder? boxBorder;
  final Color boxColor;
  final EdgeInsetsGeometry inputPadding;
  final EdgeInsetsGeometry inputMargin;
  final TextStyle? inputStyle;
  final Color? inputBackgroundColor;
  final double inputRadius;
  final BorderSide inputBorderSide;
  final void Function()? inputOnTap;
  final void Function(String value)? inputOnChanged;
  final void Function(String value)? inputOnFieldSubmitted;
  final FocusNode? inputFocusNode;
  final String? hint;
  final TextStyle hintStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final int minLine;
  final int maxLine;
  final String? title;
  final TextStyle titleStyle;
  final double titleGap;
  final IconSpec prefixIcon;
  final IconSpec suffixIcon;

  ///```dart
  /// ●, •, ♦,
  ///```
  final String obscureChar;
  final bool obscure;

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
      crossAxisAlignment: crossAxisAlignment,
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
            color: boxColor,
            borderRadius: BorderRadius.circular(boxRadius),
            border: newBoxBorder,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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

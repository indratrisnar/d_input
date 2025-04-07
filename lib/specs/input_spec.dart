part of '../d_input.dart';

class InputSpec {
  const InputSpec({
    this.controller,
    this.focusNode,
    this.enabled,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    ),
    this.margin = const EdgeInsets.all(0),
    this.style,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.border = BorderSide.none,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.hint,
    this.hintStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey,
    ),
    this.minLine,
    this.maxLine = 1,
    this.obscureChar = '●',
    this.obscure = false,
    this.keyboardType,
    this.keyboardAppearance,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.showCursor,
  });

  /// controll input
  final TextEditingController? controller;

  /// handle focus
  final FocusNode? focusNode;

  /// default: true
  final bool? enabled;

  /// contentPadding inside InputDecoration
  final EdgeInsetsGeometry padding;

  /// space to out, from TextFormField (input)
  final EdgeInsetsGeometry margin;

  /// style input text
  final TextStyle? style;

  /// background color for TextFormField (input)
  final Color? backgroundColor;

  /// radius for TextFormField (input)
  final BorderRadius borderRadius;

  /// border style inside InputDecoration
  final BorderSide border;

  /// when user tap TextFormField (input)
  final void Function()? onTap;

  /// listen changes from TextFormField (input)
  final void Function(String value)? onChanged;

  /// when user submit input
  final void Function(String value)? onFieldSubmitted;

  /// hint TextFormField
  final String? hint;

  /// styling hint text
  final TextStyle hintStyle;

  /// for text area, combine with `maxLine`
  final int? minLine;

  /// for text area, combine with `minLine`
  final int? maxLine;

  ///```dart
  /// ●, •, ♦,
  ///```
  final String obscureChar;

  /// hide char or not
  final bool obscure;

  final TextInputType? keyboardType;

  final Brightness? keyboardAppearance;

  final Color? cursorColor;

  final double? cursorHeight;

  final double cursorWidth;

  final Radius? cursorRadius;

  final bool? showCursor;

  Padding build(FocusNode? localFocusNode) {
    final localInputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: border,
    );
    return Padding(
      padding: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode ?? localFocusNode,
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        onTapOutside: (event) {
          (focusNode ?? localFocusNode)?.unfocus();
        },
        style: style,
        minLines: minLine,
        maxLines: maxLine,
        obscureText: obscure,
        obscuringCharacter: obscureChar,
        keyboardType: keyboardType,
        keyboardAppearance: keyboardAppearance,
        cursorColor: cursorColor,
        cursorHeight: cursorHeight,
        cursorWidth: cursorWidth,
        cursorRadius: cursorRadius,
        showCursor: showCursor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintStyle,
          filled: backgroundColor != null,
          fillColor: backgroundColor,
          isDense: true,
          contentPadding: padding,
          border: localInputBorder,
          errorBorder: localInputBorder,
          enabledBorder: localInputBorder,
          focusedBorder: localInputBorder,
          disabledBorder: localInputBorder,
          focusedErrorBorder: localInputBorder,
        ),
        enabled: enabled,
      ),
    );
  }
}

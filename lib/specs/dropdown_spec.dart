part of '../d_input.dart';

class DropdownSpec<T> {
  const DropdownSpec({
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemHeight = 48,
    this.menuMaxHeight,
    this.icon = const Icon(Icons.keyboard_arrow_down),
    this.dropdownColor,
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
    this.hint,
    this.hintStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey,
    ),
  });

  final T value;

  final List<DropdownMenuItem<T>> items;

  final double? itemHeight;

  final double? menuMaxHeight;

  final Widget icon;

  final Color? dropdownColor;

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
  final void Function(T? value) onChanged;

  /// hint TextFormField
  final String? hint;

  /// styling hint text
  final TextStyle hintStyle;

  Padding build(BuildContext context, FocusNode? localFocusNode) {
    final localInputBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: border,
    );
    return Padding(
      padding: margin,
      child: TapRegion(
        onTapOutside: (event) {
          (focusNode ?? localFocusNode)?.unfocus();
        },
        child: DropdownButtonFormField<T>(
          value: value,
          items: items,
          style: style,
          onChanged: onChanged,
          borderRadius: borderRadius,
          itemHeight: itemHeight,
          menuMaxHeight: menuMaxHeight,
          icon: icon,
          focusNode: focusNode ?? localFocusNode,
          dropdownColor:
              dropdownColor ?? Theme.of(context).colorScheme.surfaceContainer,
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
        ),
      ),
    );
  }
}

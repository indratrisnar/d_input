part of 'd_input.dart';

class DInputDropdown<T> extends StatelessWidget {
  const DInputDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.inputOnChanged,
    this.boxRadius = 20,
    this.boxBorder,
    this.boxColor,
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
  });

  /// current active value
  final T value;

  /// list of dropdown
  final List<DropdownMenuItem<T>> items;

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
                  child: DropdownButtonFormField<T>(
                    value: value,
                    items: items,
                    style: inputStyle,
                    onChanged: inputOnChanged,
                    borderRadius: BorderRadius.circular(boxRadius),
                    itemHeight: itemHeight,
                    menuMaxHeight: menuMaxHeight,
                    icon: icon,
                    dropdownColor: dropdownColor ??
                        Theme.of(context).colorScheme.surfaceContainer,
                    decoration: InputDecoration(
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

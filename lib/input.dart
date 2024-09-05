part of 'd_input.dart';

/// simple input with full border default
/// to styling the input decoration, use theme in the main
class DInput extends StatelessWidget {
  const DInput({
    Key? key,
    required this.controller,
    this.label,
    this.title,
    this.isRequired,
    this.hint,
    this.validator,
    this.inputType,
    this.maxLine,
    this.minLine,
    this.onTap,
    this.onChanged,
    this.spaceTitle,
    this.fillColor,
    this.radius,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 12, 16, 12),
    this.style,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  /// controller for input
  final TextEditingController controller;

  /// text inline border input
  /// if [title] not null, label will be replace
  /// [label] < [title]
  final String? label;

  /// [title] will replace [label], if label not null
  /// [title] > [label]
  final String? title;

  /// dummy placeholder
  final String? hint;

  /// asteris symbol will shown if required
  final bool? isRequired;

  /// input validator
  /// to activate validator, wrap input with 'Form widget'
  final String? Function(String? input)? validator;

  /// get realtime value from input
  final void Function(String? value)? onChanged;

  /// action tap input
  final void Function()? onTap;

  /// type for the input, like number
  final TextInputType? inputType;

  /// maximum line for input
  final int? maxLine;

  /// minimum line for input
  final int? minLine;

  /// space beetween input and title text
  /// default: 8
  final double? spaceTitle;

  /// color for input background
  final Color? fillColor;

  /// radius for corner\
  /// default:\
  /// const BorderRadius.all(Radius.circular(4.0))
  final BorderRadius? radius;

  /// padding input text to side of box input\
  /// default: const EdgeInsets.fromLTRB(16, 12, 16, 12)
  final EdgeInsetsGeometry? contentPadding;

  /// style custom input text
  final TextStyle? style;

  /// Default: false\
  /// Creates a [FormField] that contains a [TextField].\
  /// When a [controller] is specified, [initialValue] must be null (the default). If [controller] is null, then a [TextEditingController] will be constructed automatically and its text will be initialized to [initialValue] or the empty string.\
  /// For documentation about the various parameters, see the [TextField] class and [TextField.new], the constructor.
  final bool autofocus;

  /// align input\
  /// default: start
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (isRequired ?? false) const SizedBox(width: 2),
              if (isRequired ?? false)
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        if (title != null) SizedBox(height: spaceTitle ?? 8),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: inputType,
          minLines: minLine ?? 1,
          maxLines: maxLine ?? 1,
          onTap: onTap,
          onChanged: onChanged,
          textAlign: textAlign,
          style: style,
          autofocus: autofocus,
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
            border: OutlineInputBorder(
              borderSide:
                  fillColor != null ? BorderSide.none : const BorderSide(),
              borderRadius:
                  radius ?? const BorderRadius.all(Radius.circular(4.0)),
            ),
            isDense: true,
            hintText: hint,
            label: title != null
                ? null
                : label == null
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(label!),
                          if (isRequired ?? false) const SizedBox(width: 2),
                          if (isRequired ?? false)
                            const Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
            contentPadding: contentPadding,
          ),
        ),
      ],
    );
  }
}

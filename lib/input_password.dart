part of 'd_input.dart';

/// simple input password with full border default
/// to styling the input decoration, use theme in the main
class DInputPassword extends StatefulWidget {
  const DInputPassword({
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
    this.obsecureCharacter,
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

  // character which show when obsecure is active to hide real character
  final String? obsecureCharacter;

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
  State<DInputPassword> createState() => _DInputPasswordState();
}

class _DInputPasswordState extends State<DInputPassword> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (widget.isRequired ?? false) const SizedBox(width: 2),
              if (widget.isRequired ?? false)
                const Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        if (widget.title != null) SizedBox(height: widget.spaceTitle ?? 8),
        TextFormField(
          controller: widget.controller,
          obscureText: isObsecure,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.inputType,
          minLines: widget.minLine ?? 1,
          maxLines: widget.maxLine ?? 1,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          textAlign: widget.textAlign,
          style: widget.style,
          obscuringCharacter: widget.obsecureCharacter ?? '●',
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObsecure = !isObsecure;
                });
              },
              icon: Icon(isObsecure ? Icons.visibility_off : Icons.visibility),
            ),
            fillColor: widget.fillColor,
            filled: widget.fillColor != null,
            border: OutlineInputBorder(
              borderSide: widget.fillColor != null
                  ? BorderSide.none
                  : const BorderSide(),
              borderRadius:
                  widget.radius ?? const BorderRadius.all(Radius.circular(4.0)),
            ),
            isDense: true,
            hintText: widget.hint,
            label: widget.title != null
                ? null
                : widget.label == null
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(widget.label!),
                          if (widget.isRequired ?? false)
                            const SizedBox(width: 2),
                          if (widget.isRequired ?? false)
                            const Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
            contentPadding: widget.contentPadding,
          ),
        ),
      ],
    );
  }
}

library d_input;

import 'package:flutter/material.dart';

typedef DValidator = String? Function(String? input);
typedef OnChange = void Function(String? value);
typedef OnTap = void Function();

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
  final DValidator? validator;

  /// get realtime value from input
  final OnChange? onChanged;

  /// action tap input
  final OnTap? onTap;

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
          ),
        ),
      ],
    );
  }
}

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
  final DValidator? validator;

  /// get realtime value from input
  final OnChange? onChanged;

  /// action tap input
  final OnTap? onTap;

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
          obscuringCharacter: widget.obsecureCharacter ?? '●',
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
          ),
        ),
      ],
    );
  }
}

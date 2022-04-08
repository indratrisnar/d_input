import 'package:flutter/material.dart';

typedef DValidator = String? Function(String? input);

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

  /// type for the input, like number
  final TextInputType? inputType;

  /// maximum line for input
  final int? maxLine;

  /// minimum line for input
  final int? minLine;
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
                Text(
                  '*',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          ),
        if (title != null) const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: inputType,
          minLines: minLine ?? 1,
          maxLines: maxLine ?? 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
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
                            Text(
                              '*',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                        ],
                      ),
          ),
        ),
      ],
    );
  }
}

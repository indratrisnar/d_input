part of 'd_input.dart';

enum InputFileComposition { icon, field, picker }

class DInputFile extends StatefulWidget {
  const DInputFile({
    super.key,
    required this.controller,
    required this.filePicked,
    this.filePicker,
    this.composition = (
      InputFileComposition.icon,
      InputFileComposition.field,
      InputFileComposition.picker,
    ),
    this.compositionVisibility = (true, true, true),
    this.pickerIcon = const IconSpec(
      icon: Icons.file_open,
    ),
    this.allowedExtensions = const [
      'txt',
      'doc',
      'docx',
      'csv',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
      'pdf',
      'zip',
      'rar',
      '7z'
    ],
    this.enabled = false,
    this.noBoxBorder = false,
    this.boxBorderRadius = const BorderRadius.all(Radius.circular(20)),
    this.boxColor,
    this.boxBorder,
    this.shapeBoxBorder,
    this.focusedBoxColor,
    this.focusedBoxBorder,
    this.focusedShapeBoxBorder,
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
    this.hint = 'Choose File',
    this.hintStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey,
    ),
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.minLine = 1,
    this.maxLine = 1,
    this.obscureChar = '●',
    this.obscure = false,
  });

  /// controll input
  final TextEditingController controller;

  final void Function(XFile? xFile) filePicked;

  /// from package [file_picker](https://pub.dev/packages/file_picker)
  ///
  /// default: FilePicker.platform
  final FilePicker? filePicker;

  /// default:
  ///
  /// ```
  /// (InputDateComposition.field, InputDateComposition.picker)
  /// ```
  final (
    InputFileComposition,
    InputFileComposition,
    InputFileComposition,
  ) composition;

  /// default: (true, true, true, true)
  final (bool, bool, bool) compositionVisibility;

  /// Icon for file picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.file_open)
  /// ```
  final IconSpec pickerIcon;

  final List<String> allowedExtensions;

  /// default: false
  final bool enabled;

  /// default: false
  final bool noBoxBorder;

  /// radius for all corner (box wrapper)
  ///
  /// default:
  ///
  /// `const BorderRadius.all(Radius.circular(20))`
  final BorderRadius boxBorderRadius;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? boxColor;

  /// styling for box border,
  ///
  /// will prioritize shapeBoxborder, if it's set
  ///
  /// default:
  /// ```dart
  /// const BorderSide(
  ///   color: Colors.grey,
  ///   width: 1,
  ///   strokeAlign: BorderSide.strokeAlignOutside,
  /// ),
  /// ```
  final BorderSide? boxBorder;

  /// default: RoundedRectangleBorder
  final ShapeBorder? shapeBoxBorder;

  /// background color
  ///
  /// default: Colors.grey.shade100
  final Color? focusedBoxColor;

  /// styling for box border
  ///
  /// ```dart
  /// BorderSide(
  ///   color: Theme.of(context).primaryColor,
  ///   width: 2,
  ///   strokeAlign: BorderSide.strokeAlignOutside,
  /// ),
  /// ```
  final BorderSide? focusedBoxBorder;

  /// default: RoundedRectangleBorder
  final ShapeBorder? focusedShapeBoxBorder;

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
  /// default: Choose Image
  final String hint;

  /// styling hint text
  final TextStyle hintStyle;

  /// show text title above box input
  final String? title;

  /// styling `title`
  final TextStyle titleStyle;

  /// give space between title and box input
  final double titleGap;

  /// for text area, combine with `maxLine`
  final int minLine;

  /// for text area, combine with `minLine`
  final int maxLine;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  ///```dart
  /// ●, •, ♦,
  ///```
  final String obscureChar;

  /// hide char or not
  final bool obscure;

  @override
  State<DInputFile> createState() => _DInputFileState();
}

class _DInputFileState extends State<DInputFile> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode!.hasFocus) return;
    listenFocus.value = localFocusNode!.hasFocus;
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputFocusNode!.hasFocus) return;
    listenFocus.value = widget.inputFocusNode!.hasFocus;
  }

  void pickFile() async {
    final result = await (widget.filePicker ?? FilePicker.platform).pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    final xFile = result?.xFiles.single;
    if (xFile != null) {
      widget.controller.text = xFile.name;
    }

    widget.filePicked(xFile);
  }

  @override
  void initState() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode!.addListener(_listenLocalFocusNode);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.removeListener(_listenParentFocusNode);
    } else {
      localFocusNode!.removeListener(_listenLocalFocusNode);
      localFocusNode!.dispose();
    }
    listenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.allowedExtensions.isNotEmpty);

    final primaryColor = Theme.of(context).primaryColor;

    // setup box
    final localBoxBorderRadius = widget.boxBorderRadius;

    final localBoxColor = widget.boxColor ?? Colors.grey.shade100;
    final localBoxBorder = widget.boxBorder ??
        const BorderSide(
          color: Colors.grey,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        );
    final localShapeBoxBorder = widget.shapeBoxBorder ??
        RoundedRectangleBorder(
          borderRadius: localBoxBorderRadius,
          side: widget.noBoxBorder ? BorderSide.none : localBoxBorder,
        );

    final localFocusedBoxColor = widget.focusedBoxColor ?? localBoxColor;
    final localFocusedBoxBorder = widget.focusedBoxBorder ??
        BorderSide(
          color: primaryColor,
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        );
    final localFocusedShapeBoxBorder = widget.focusedShapeBoxBorder ??
        RoundedRectangleBorder(
          borderRadius: localBoxBorderRadius,
          side: widget.noBoxBorder ? BorderSide.none : localFocusedBoxBorder,
        );

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
        ValueListenableBuilder<bool>(
          valueListenable: listenFocus,
          builder: (context, isFocus, child) {
            final color = isFocus ? localFocusedBoxColor : localBoxColor;
            final shape =
                isFocus ? localFocusedShapeBoxBorder : localShapeBoxBorder;
            return Material(
              shape: shape,
              color: color,
              child: child,
            );
          },
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignmentBox,
            children: [
              buildComposition(
                  widget.composition.$1, widget.compositionVisibility.$1),
              buildComposition(
                  widget.composition.$2, widget.compositionVisibility.$2),
              buildComposition(
                  widget.composition.$3, widget.compositionVisibility.$3),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildComposition(InputFileComposition? composition, bool visible) {
    if (!visible) return const SizedBox();
    return switch (composition) {
      InputFileComposition.field => buildInputField(),
      InputFileComposition.picker =>
        widget.pickerIcon.copyWith(onTap: pickFile).build(context),
      _ => const SizedBox(),
    };
  }

  Expanded buildInputField() {
    // setup input
    final localInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.inputRadius),
      borderSide: widget.inputBorderSide,
    );
    return Expanded(
      child: Padding(
        padding: widget.inputMargin,
        child: TextFormField(
          controller: widget.controller,
          style: widget.inputStyle,
          minLines: widget.minLine,
          maxLines: widget.maxLine,
          onTap: widget.inputOnTap,
          onChanged: widget.inputOnChanged,
          onFieldSubmitted: widget.inputOnFieldSubmitted,
          focusNode: widget.inputFocusNode ?? localFocusNode,
          obscureText: widget.obscure,
          obscuringCharacter: widget.obscureChar,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.hintStyle,
            filled: widget.inputBackgroundColor != null,
            fillColor: widget.inputBackgroundColor,
            isDense: true,
            contentPadding: widget.inputPadding,
            border: localInputBorder,
            errorBorder: localInputBorder,
            enabledBorder: localInputBorder,
            focusedBorder: localInputBorder,
            disabledBorder: localInputBorder,
            focusedErrorBorder: localInputBorder,
          ),
          enabled: widget.enabled,
        ),
      ),
    );
  }
}

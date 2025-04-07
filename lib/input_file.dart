part of 'd_input.dart';

enum InputFileComposition { field, picker }

class DInputFile extends StatefulWidget {
  const DInputFile({
    super.key,
    required this.filePicked,
    this.filePicker,
    this.composition = (
      InputFileComposition.field,
      InputFileComposition.picker,
    ),
    this.compositionVisibility = (true, true),
    this.pickerIcon = const IconSpec(
      icon: Icons.attach_file,
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
    this.titleSpec,
    this.boxSpec = const BoxSpec(),
    this.inputSpec = const InputSpec(),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
  });

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
  ) composition;

  /// default: (true, true)
  final (bool, bool) compositionVisibility;

  /// Icon for file picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.attach_file)
  /// ```
  final IconSpec pickerIcon;

  final List<String> allowedExtensions;

  final TitleSpec? titleSpec;

  final BoxSpec boxSpec;

  final InputSpec inputSpec;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  @override
  State<DInputFile> createState() => _DInputFileState();
}

class _DInputFileState extends State<DInputFile> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;

  void pickFile() async {
    final result = await (widget.filePicker ?? FilePicker.platform).pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    final xFile = result?.xFiles.single;
    if (xFile != null) {
      widget.inputSpec.controller?.text = xFile.name;
    }

    widget.filePicked(xFile);
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputSpec.focusNode?.hasFocus) return;
    listenFocus.value = widget.inputSpec.focusNode?.hasFocus ?? false;
  }

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode?.hasFocus) return;
    listenFocus.value = localFocusNode?.hasFocus ?? false;
  }

  @override
  void initState() {
    if (widget.inputSpec.focusNode != null) {
      widget.inputSpec.focusNode?.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode?.addListener(_listenLocalFocusNode);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.inputSpec.focusNode != null) {
      widget.inputSpec.focusNode?.removeListener(_listenParentFocusNode);
    } else {
      localFocusNode?.removeListener(_listenLocalFocusNode);
      localFocusNode?.dispose();
    }
    listenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.allowedExtensions.isNotEmpty);

    return Column(
      crossAxisAlignment: widget.crossAxisAlignmentTitle,
      children: [
        if (widget.titleSpec != null) widget.titleSpec!,
        ValueListenableBuilder<bool>(
          valueListenable: listenFocus,
          builder: (context, isFocus, child) {
            final modifiedBoxSpec = widget.boxSpec.render(context);
            return Padding(
              padding: modifiedBoxSpec.margin,
              child: Material(
                shape: isFocus
                    ? modifiedBoxSpec.focusedShapeBorder
                    : modifiedBoxSpec.shapeBorder,
                color: isFocus
                    ? modifiedBoxSpec.focusedColor
                    : modifiedBoxSpec.color,
                child: child,
              ),
            );
          },
          child: Row(
            crossAxisAlignment: widget.crossAxisAlignmentBox,
            children: [
              buildComposition(
                  widget.composition.$1, widget.compositionVisibility.$1),
              buildComposition(
                  widget.composition.$2, widget.compositionVisibility.$2),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildComposition(InputFileComposition? composition, bool visible) {
    if (!visible) return const SizedBox();
    return switch (composition) {
      InputFileComposition.field => Expanded(
          child: widget.inputSpec.build(localFocusNode),
        ),
      InputFileComposition.picker =>
        widget.pickerIcon.copyWith(onTap: pickFile).build(context),
      _ => const SizedBox(),
    };
  }
}

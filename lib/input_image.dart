part of 'd_input.dart';

enum InputImageComposition { fileName, camera, gallery, visibility }

class DInputImage extends StatefulWidget {
  const DInputImage({
    super.key,
    required this.controller,
    required this.imagePicker,
    required this.imagePicked,
    this.imageView,
    this.imageGap = 8,
    this.composition = (
      InputImageComposition.visibility,
      InputImageComposition.fileName,
      InputImageComposition.camera,
      InputImageComposition.gallery
    ),
    this.compositionVisibility = (true, true, true, true),
    this.showImage = true,
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
    this.hint = 'Choose Image',
    this.hintStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.grey,
    ),
    this.title,
    this.titleStyle =
        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    this.titleGap = 12,
    this.visibilityIcon = const IconSpec(
      icon: Icons.visibility,
    ),
    this.visibilityOffIcon = const IconSpec(
      icon: Icons.visibility_off,
    ),
    this.cameraIcon = const IconSpec(
      icon: Icons.photo_camera,
    ),
    this.galleryIcon = const IconSpec(
      icon: Icons.photo_library,
    ),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.minLine = 1,
    this.maxLine = 1,
    this.obscureChar = '●',
    this.obscure = false,
  });

  /// controll input
  final TextEditingController controller;

  final ImagePicker imagePicker;

  final void Function(XFile? xFile) imagePicked;

  final Widget Function(XFile? xFile)? imageView;

  /// default: 8
  final double imageGap;

  /// default:
  ///
  /// ```
  /// (InputImageComposition.fileName, InputImageComposition.camera, InputImageComposition.gallery)
  /// ```
  final (
    InputImageComposition a,
    InputImageComposition b,
    InputImageComposition c,
    InputImageComposition d,
  ) composition;

  /// default: (true, true, true, true)
  final (bool a, bool b, bool c, bool d) compositionVisibility;

  /// default: true
  final bool showImage;

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

  /// Icon for visibility
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.visibility)
  /// ```
  final IconSpec visibilityIcon;

  /// Icon for visibility off
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.visibility_off)
  /// ```
  final IconSpec visibilityOffIcon;

  /// Icon for camera
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```
  /// const IconSpec(icon: Icons.photo_camera)
  /// ```
  final IconSpec cameraIcon;

  /// Icon gallery
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```dart
  /// const IconSpec(icon: Icons.photo_library)
  /// ```
  final IconSpec galleryIcon;

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
  State<DInputImage> createState() => _DInputImageState();
}

class _DInputImageState extends State<DInputImage> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;
  final ValueNotifier<XFile?> xFilePicked = ValueNotifier(null);
  final localShowImage = ValueNotifier(true);

  void _listenLocalFocusNode() {
    if (listenFocus.value == localFocusNode!.hasFocus) return;
    listenFocus.value = localFocusNode!.hasFocus;
  }

  void _listenParentFocusNode() {
    if (listenFocus.value == widget.inputFocusNode!.hasFocus) return;
    listenFocus.value = widget.inputFocusNode!.hasFocus;
  }

  void pickImage(ImageSource source) async {
    final result = await widget.imagePicker.pickImage(source: source);
    if (result == null) return widget.imagePicked(result);

    xFilePicked.value = result;
    widget.controller.text = result.name;
    widget.imagePicked(result);
  }

  @override
  void initState() {
    if (widget.inputFocusNode != null) {
      widget.inputFocusNode!.addListener(_listenParentFocusNode);
    } else {
      localFocusNode = FocusNode();
      localFocusNode!.addListener(_listenLocalFocusNode);
    }
    localShowImage.value = widget.showImage;
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
    xFilePicked.dispose();
    localShowImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              buildComposition(
                  widget.composition.$4, widget.compositionVisibility.$4),
            ],
          ),
        ),
        if (widget.showImage)
          Padding(
            padding: EdgeInsets.only(top: widget.imageGap),
            child: ValueListenableBuilder(
              valueListenable: localShowImage,
              builder: (context, show, child) {
                if (!show) return const SizedBox();
                return ValueListenableBuilder(
                  valueListenable: xFilePicked,
                  builder: (context, xFile, child) {
                    if (widget.imageView == null) {
                      if (xFile == null) return const SizedBox();
                      return FutureBuilder(
                        future: xFile.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Image.memory(
                            snapshot.data!,
                            width: 192,
                            height: 192,
                          );
                        },
                      );
                    }
                    return widget.imageView!(xFile);
                  },
                );
              },
            ),
          )
      ],
    );
  }

  Widget buildComposition(InputImageComposition? composition, bool visible) {
    if (!visible) return const SizedBox();
    return switch (composition) {
      InputImageComposition.fileName => buildInputField(),
      InputImageComposition.camera => widget.cameraIcon
          .copyWith(
            onTap: () => pickImage(ImageSource.camera),
          )
          .build(context),
      InputImageComposition.gallery => widget.galleryIcon
          .copyWith(
            onTap: () => pickImage(ImageSource.gallery),
          )
          .build(context),
      InputImageComposition.visibility => ValueListenableBuilder(
          valueListenable: localShowImage,
          builder: (context, show, child) {
            final iconSpec =
                show ? widget.visibilityIcon : widget.visibilityOffIcon;
            return iconSpec
                .copyWith(
                  onTap: () => localShowImage.value = !localShowImage.value,
                )
                .build(context);
          },
        ),
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

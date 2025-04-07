part of 'd_input.dart';

enum InputImageComposition { fileName, cameraPicker, galleryPicker, visibility }

class DInputImage extends StatefulWidget {
  const DInputImage({
    super.key,
    required this.imagePicked,
    this.imagePicker,
    this.imageView,
    this.imageGap = 12,
    this.composition = (
      InputImageComposition.visibility,
      InputImageComposition.fileName,
      InputImageComposition.cameraPicker,
      InputImageComposition.galleryPicker
    ),
    this.compositionVisibility = (true, true, true, true),
    this.showImage = true,
    this.titleSpec,
    this.boxSpec = const BoxSpec(),
    this.inputSpec = const InputSpec(),
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
  });

  /// from package [image_picker](https://pub.dev/packages/image_picker)
  ///
  /// default: ImagePicker()
  final ImagePicker? imagePicker;

  final void Function(XFile? xFile) imagePicked;

  final Widget Function(XFile? xFile)? imageView;

  /// default: 12
  final double imageGap;

  /// default:
  ///
  /// ```
  /// (InputImageComposition.fileName, InputImageComposition.camera, InputImageComposition.gallery)
  /// ```
  final (
    InputImageComposition,
    InputImageComposition,
    InputImageComposition,
    InputImageComposition,
  ) composition;

  /// default: (true, true, true, true)
  final (bool, bool, bool, bool) compositionVisibility;

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

  /// default: true
  final bool showImage;

  final TitleSpec? titleSpec;

  final BoxSpec boxSpec;

  final InputSpec inputSpec;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  @override
  State<DInputImage> createState() => _DInputImageState();
}

class _DInputImageState extends State<DInputImage> {
  final listenFocus = ValueNotifier(false);
  FocusNode? localFocusNode;
  final ValueNotifier<XFile?> xFilePicked = ValueNotifier(null);
  final localShowImage = ValueNotifier(true);

  void pickImage(ImageSource source) async {
    final result =
        await (widget.imagePicker ?? ImagePicker()).pickImage(source: source);

    if (result != null) {
      xFilePicked.value = result;
      widget.inputSpec.controller?.text = result.name;
    }

    widget.imagePicked(result);
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
    localShowImage.value = widget.showImage;
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
    xFilePicked.dispose();
    localShowImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    if (widget.imageView != null) {
                      return widget.imageView!(xFile);
                    }
                    if (xFile == null) return const SizedBox();
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: widget.boxSpec.borderRadius,
                        color: widget.boxSpec.color,
                        border: Border.fromBorderSide(widget.boxSpec.border),
                      ),
                      height: 192,
                      width: 192,
                      padding: const EdgeInsets.all(12),
                      child: FutureBuilder(
                        future: xFile.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Image.memory(snapshot.data!);
                        },
                      ),
                    );
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
      InputImageComposition.fileName => Expanded(
          child: widget.inputSpec.build(localFocusNode),
        ),
      InputImageComposition.cameraPicker => widget.cameraIcon
          .copyWith(
            onTap: () => pickImage(ImageSource.camera),
          )
          .build(context),
      InputImageComposition.galleryPicker => widget.galleryIcon
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
}

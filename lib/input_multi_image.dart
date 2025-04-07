part of 'd_input.dart';

enum InputMultiImageComposition {
  visibility,
  text,
  pickerReplace,
  pickerAdd,
}

class DInputMultiImage extends StatefulWidget {
  const DInputMultiImage({
    super.key,
    required this.onPicked,
    this.onChanged,
    this.onDelete,
    this.imagePicker,
    this.imageView,
    this.text,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.black87,
    ),
    this.imageGap = 12,
    this.customImageView,
    this.customText,
    this.composition = (
      InputMultiImageComposition.visibility,
      InputMultiImageComposition.text,
      InputMultiImageComposition.pickerReplace,
      InputMultiImageComposition.pickerAdd,
    ),
    this.compositionVisibility = (true, true, true, true),
    this.visibilityIcon = const IconSpec(
      icon: Icons.visibility,
    ),
    this.visibilityOffIcon = const IconSpec(
      icon: Icons.visibility_off,
    ),
    this.pickerReplaceIcon = const IconSpec(
      icon: Icons.photo_library,
    ),
    this.pickerAddIcon = const IconSpec(
      icon: Icons.add_photo_alternate,
    ),
    this.newImageAtFirst = false,
    this.showImage = true,
    this.titleSpec,
    this.boxSpec = const BoxSpec(),
    this.crossAxisAlignmentTitle = CrossAxisAlignment.start,
    this.crossAxisAlignmentBox = CrossAxisAlignment.center,
    this.paddingImageList = const EdgeInsets.all(0),
  });

  /// from package [image_picker](https://pub.dev/packages/image_picker)
  ///
  /// default: ImagePicker()
  final ImagePicker? imagePicker;

  final void Function(List<XFile> xFiles) onPicked;

  final void Function(List<XFile> xFiles)? onChanged;

  final void Function(XFile xFile)? onDelete;

  final Widget Function(
      List<XFile> xFiles, void Function(XFile xFile) onDelete)? imageView;

  final String Function(List<XFile> xFiles)? text;

  final TextStyle textStyle;

  /// default: 12
  final double imageGap;

  final Widget? customImageView;

  final Widget? customText;

  /// default:
  ///
  /// ```
  /// (InputMultiImageComposition.fileName, InputMultiImageComposition.camera, InputMultiImageComposition.gallery)
  /// ```
  final (
    InputMultiImageComposition,
    InputMultiImageComposition,
    InputMultiImageComposition,
    InputMultiImageComposition,
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

  /// Icon picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```dart
  /// const IconSpec(icon: Icons.photo_library)
  /// ```
  final IconSpec pickerReplaceIcon;

  /// Icon picker
  ///
  /// Action property will be disabled
  ///
  /// default:
  /// ```dart
  /// const IconSpec(icon: Icons.add_photo_alternate)
  /// ```
  final IconSpec pickerAddIcon;

  /// default: false
  final bool newImageAtFirst;

  /// default: true
  final bool showImage;

  final TitleSpec? titleSpec;

  final BoxSpec boxSpec;

  /// arrange title and box input
  final CrossAxisAlignment crossAxisAlignmentTitle;

  /// arrange widget inside box
  final CrossAxisAlignment crossAxisAlignmentBox;

  final EdgeInsetsGeometry paddingImageList;

  @override
  State<DInputMultiImage> createState() => _DInputMultiImageState();
}

class _DInputMultiImageState extends State<DInputMultiImage> {
  final ValueNotifier<List<XFile>> xFilesState = ValueNotifier([]);
  final localShowImage = ValueNotifier(true);

  void listenXFiles() {
    if (widget.onChanged != null) widget.onChanged!(xFilesState.value);
  }

  void pickImages(bool isReplace) async {
    final result = await (widget.imagePicker ?? ImagePicker()).pickMultiImage();
    widget.onPicked(result);
    if (result.isEmpty) return;

    if (widget.customImageView != null) return;

    if (isReplace) {
      // replace list
      xFilesState.value = result;
    } else {
      // add new item
      xFilesState.value = [
        if (widget.newImageAtFirst) ...result,
        ...xFilesState.value,
        if (!widget.newImageAtFirst) ...result
      ];
    }

    listenXFiles();
  }

  void removeImage(XFile xFile) {
    if (widget.customImageView != null) return;

    xFilesState.value =
        xFilesState.value.where((e) => e.path != xFile.path).toList();
    if (widget.onDelete != null) widget.onDelete!(xFile);
    listenXFiles();
  }

  @override
  void initState() {
    localShowImage.value = widget.showImage;
    super.initState();
  }

  @override
  void dispose() {
    xFilesState.dispose();
    localShowImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modifiedBoxSpec = widget.boxSpec.render(context);
    return Column(
      crossAxisAlignment: widget.crossAxisAlignmentTitle,
      children: [
        if (widget.titleSpec != null) widget.titleSpec!,
        Padding(
          padding: modifiedBoxSpec.margin,
          child: Material(
            shape: modifiedBoxSpec.shapeBorder,
            color: modifiedBoxSpec.color,
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
        ),
        if (widget.showImage)
          Padding(
            padding: EdgeInsets.only(top: widget.imageGap),
            child: ValueListenableBuilder(
              valueListenable: localShowImage,
              builder: (context, show, child) {
                if (!show) return const SizedBox();
                if (widget.customImageView != null) {
                  return widget.customImageView!;
                }
                return ValueListenableBuilder(
                  valueListenable: xFilesState,
                  builder: (context, xFiles, child) {
                    if (widget.imageView == null) {
                      if (xFiles.isEmpty) return const SizedBox();
                      return buildImageList(xFiles);
                    }
                    return widget.imageView!(xFiles, removeImage);
                  },
                );
              },
            ),
          )
      ],
    );
  }

  Widget buildComposition(
      InputMultiImageComposition? composition, bool visible) {
    if (!visible) return const SizedBox();
    return switch (composition) {
      InputMultiImageComposition.text => Expanded(
          child: widget.customText ??
              ValueListenableBuilder(
                valueListenable: xFilesState,
                builder: (context, xFiles, child) {
                  final text = widget.text != null
                      ? widget.text!(xFiles)
                      : xFiles.isNotEmpty
                          ? '${xFiles.length} Items'
                          : 'Choose Images';
                  final style = xFiles.isNotEmpty
                      ? widget.textStyle
                      : const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        );
                  return Text(text, style: style);
                },
              ),
        ),
      InputMultiImageComposition.pickerReplace => widget.pickerReplaceIcon
          .copyWith(onTap: () => pickImages(true))
          .build(context),
      InputMultiImageComposition.pickerAdd => widget.pickerAddIcon
          .copyWith(onTap: () => pickImages(false))
          .build(context),
      InputMultiImageComposition.visibility => ValueListenableBuilder(
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

  Widget buildImageList(List<XFile> xFiles) {
    return SizedBox(
      height: 192,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: xFiles.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        padding: widget.paddingImageList,
        itemBuilder: (context, index) {
          final xFile = xFiles[index];
          return ClipRRect(
            borderRadius: widget.boxSpec.borderRadius,
            child: FutureBuilder(
              future: xFile.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    width: 192,
                    child: Placeholder(color: Colors.grey.shade200),
                  );
                }
                return SizedBox(
                  width: 192,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconSpec(
                          onTap: () => removeImage(xFile),
                          borderRadius: BorderRadius.circular(10),
                          iconSize: 20,
                          boxSize: const Size(30, 30),
                          icon: Icons.delete,
                          color: Colors.white,
                          backgroundColor: Colors.redAccent,
                          elevation: 6,
                          shadowColor: Colors.redAccent.shade100,
                        ).build(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

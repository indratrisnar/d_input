part of 'd_input.dart';

class IconSpec {
  final IconData? icon;
  final String? iconAsset;
  final double iconSize;
  final Color? color;
  final Color backgroundColor;
  final Size boxSize;
  final Alignment alignment;
  final void Function()? onTap;

  /// will ignore `radius`
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final EdgeInsetsGeometry margin;

  const IconSpec({
    this.icon,
    this.iconAsset,
    this.alignment = Alignment.center,
    this.color,
    this.backgroundColor = Colors.transparent,
    this.iconSize = 24,
    this.boxSize = const Size(56, 56),
    this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.splashColor,
    this.margin = const EdgeInsets.all(0),
  });

  Widget build(BuildContext context) {
    if (icon == null && iconAsset == null) return const SizedBox();
    final iconColor = color ?? Theme.of(context).primaryColor;
    return Padding(
      padding: margin,
      child: Material(
        color: backgroundColor,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          splashColor: splashColor,
          child: SizedBox(
            width: boxSize.width,
            height: boxSize.height,
            child: Align(
              alignment: alignment,
              child: icon != null
                  ? Icon(
                      icon,
                      color: iconColor,
                      size: iconSize,
                    )
                  : ImageIcon(
                      AssetImage(iconAsset!),
                      size: 24,
                      color: iconColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  IconSpec copyWith({
    IconData? icon,
    String? iconAsset,
    double? iconSize,
    Color? color,
    Color? backgroundColor,
    Size? boxSize,
    Alignment? alignment,
    void Function()? onTap,
    BorderRadius? borderRadius,
    Color? splashColor,
    EdgeInsetsGeometry? margin,
  }) {
    return IconSpec(
      icon: icon ?? this.icon,
      iconAsset: iconAsset ?? this.iconAsset,
      iconSize: iconSize ?? this.iconSize,
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      boxSize: boxSize ?? this.boxSize,
      alignment: alignment ?? this.alignment,
      onTap: onTap ?? this.onTap,
      borderRadius: borderRadius ?? this.borderRadius,
      splashColor: splashColor ?? this.splashColor,
      margin: margin ?? this.margin,
    );
  }
}

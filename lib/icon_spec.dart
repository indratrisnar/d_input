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

  /// if `borderRadius` null
  final double? radius;

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
    this.radius,
    this.borderRadius,
    this.splashColor,
    this.margin = const EdgeInsets.all(0),
  });

  Widget build(BuildContext context, double boxRadius) {
    if (icon == null && iconAsset == null) return const SizedBox();
    final iconColor = color ?? Theme.of(context).primaryColor;
    return Padding(
      padding: margin,
      child: Material(
        color: backgroundColor,
        borderRadius:
            borderRadius ?? BorderRadius.circular(radius ?? boxRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius:
              borderRadius ?? BorderRadius.circular(radius ?? boxRadius),
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
}

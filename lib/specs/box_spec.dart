part of '../d_input.dart';

class BoxSpec {
  const BoxSpec({
    this.noBorder = false,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.color = const Color(0xffF5F5F5),
    this.border = const BorderSide(
      color: Colors.grey,
      width: 1,
      strokeAlign: BorderSide.strokeAlignInside,
    ),
    this.shapeBorder,
    this.focusedColor = const Color(0xffF5F5F5),
    this.focusedBorder,
    this.focusedShapeBorder,
    this.margin = const EdgeInsets.all(0),
  });

  /// default: false
  final bool noBorder;

  /// radius for all corner (box wrapper)
  ///
  /// default:
  ///
  /// `const BorderRadius.all(Radius.circular(20))`
  final BorderRadius borderRadius;

  /// background color
  ///
  /// default: const Color(0xffF5F5F5) || Colors.grey.shade100
  final Color color;

  /// styling for box border,
  ///
  /// will prioritize shapeBoxborder, if it's set
  ///
  /// default:
  /// ```dart
  /// const BorderSide(
  ///   color: Colors.grey,
  ///   width: 1,
  ///   strokeAlign: BorderSide.strokeAlignInside,
  /// ),
  /// ```
  final BorderSide border;

  /// default: RoundedRectangleBorder
  final ShapeBorder? shapeBorder;

  /// background color
  ///
  /// default: const Color(0xffF5F5F5) || Colors.grey.shade100
  final Color focusedColor;

  /// styling for box border
  ///
  /// ```dart
  /// BorderSide(
  ///   color: Theme.of(context).primaryColor,
  ///   width: 2,
  ///   strokeAlign: BorderSide.strokeAlignInside,
  /// ),
  /// ```
  final BorderSide? focusedBorder;

  /// default: RoundedRectangleBorder
  final ShapeBorder? focusedShapeBorder;

  final EdgeInsetsGeometry margin;

  BoxSpec render(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final localFocusedBorder = focusedBorder ??
        BorderSide(
          color: primaryColor,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        );
    return BoxSpec(
      noBorder: noBorder,
      borderRadius: borderRadius,
      color: color,
      border: border,
      shapeBorder: shapeBorder ?? _defaultShapeBorder(border),
      focusedColor: focusedColor,
      focusedBorder: localFocusedBorder,
      focusedShapeBorder:
          focusedShapeBorder ?? _defaultShapeBorder(localFocusedBorder),
      margin: margin,
    );
  }

  ShapeBorder _defaultShapeBorder(BorderSide borderSide) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: noBorder ? BorderSide.none : borderSide,
    );
  }
}

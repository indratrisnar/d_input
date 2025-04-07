part of '../d_input.dart';

class TitleSpec extends StatelessWidget {
  const TitleSpec({
    super.key,
    this.text,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.black87,
    ),
    this.custom,
    this.gap = 8,
  }) : assert(gap >= 0);

  /// show text title above box input
  final String? text;

  /// styling `title`
  final TextStyle textStyle;

  final Widget? custom;

  /// give space between title and box
  ///
  /// must be >= 0
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        custom ??
            (text != null
                ? Text(
                    text!,
                    style: textStyle,
                  )
                : const SizedBox()),
        if (gap > 0 && (text != null || custom != null)) SizedBox(height: gap),
      ],
    );
  }
}

import 'package:flutter/widgets.dart';

class GoResponsiveOrientationBuilder extends StatelessWidget {
  const GoResponsiveOrientationBuilder({
    super.key,
    required this.landscape,
    required this.portrait,
  });

  final Widget landscape;
  final Widget portrait;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return landscape;
    }
    return portrait;
  }
}

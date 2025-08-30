import 'package:flutter/widgets.dart';

class GoResponsiveOrientationBuilder extends StatelessWidget {
  const GoResponsiveOrientationBuilder({
    super.key,
    required this.portrait,
    required this.landscape,
  });

  final Widget portrait;
  final Widget landscape;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      return landscape;
    }
    return portrait;
  }
}

import 'package:flutter/widgets.dart';
import 'package:go_responsive/go_responsive.dart';

// **************************************************************************
// GoResponsiveGenerator
// **************************************************************************

class GoResponsiveWidget extends StatelessWidget {
  const GoResponsiveWidget({
    super.key,
    required this.defaultWidget,
    this.small,
    this.medium,
    this.large,
  });

  final Widget defaultWidget;

  final Widget? small;

  final Widget? medium;

  final Widget? large;

  @override
  Widget build(BuildContext context) {
    return context.goResponsiveValue(
      small: small,
      medium: medium,
      large: large,
      defaultValue: defaultWidget,
    );
  }
}

extension GoResponsiveBuildContextExtensions on BuildContext {
  GoResponsiveData get goResponsiveData => GoResponsiveBuilder.of(this);
  bool get isSmall => goResponsiveData.smallerOrEqualTo('small');
  bool get isMedium => goResponsiveData.between('small', 'medium');
  bool get isLarge => goResponsiveData.between('medium', 'large');
  T goResponsiveValue<T>({
    required T defaultValue,
    T? small,
    T? medium,
    T? large,
  }) {
    if (isSmall) {
      if (small != null) return small;
    }

    if (isMedium) {
      if (medium != null) return medium;
    }

    if (isLarge) {
      if (large != null) return large;
    }

    return defaultValue;
  }
}

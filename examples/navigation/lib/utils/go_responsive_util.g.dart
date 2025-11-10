// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_responsive_util.dart';

// **************************************************************************
// GoResponsiveGenerator
// **************************************************************************

class GoResponsiveBreakpoints {
  static String compact = 'compact';

  static String medium = 'medium';

  static String expanded = 'expanded';
}

class GoResponsiveWidget extends StatelessWidget {
  const GoResponsiveWidget({
    super.key,
    this.compact,
    this.medium,
    this.expanded,
    required this.defaultWidget,
  });

  final Widget? compact;

  final Widget? medium;

  final Widget? expanded;

  final Widget defaultWidget;

  @override
  Widget build(BuildContext context) {
    return context.goResponsiveValue(
      compact: compact,
      medium: medium,
      expanded: expanded,
      defaultValue: defaultWidget,
    );
  }
}

extension GoResponsiveBuildContextExtensions on BuildContext {
  GoResponsiveData get goResponsiveData => GoResponsive.of(this);

  T goResponsiveValue<T>({
    T? compact,
    T? medium,
    T? expanded,
    required T defaultValue,
  }) {
    if (isCompact) {
      if (compact != null) return compact;
    }

    if (isMedium) {
      if (medium != null) return medium;
    }

    if (isExpanded) {
      if (expanded != null) return expanded;
    }

    return defaultValue;
  }

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isCompact =>
      goResponsiveData.smallerOrEqualTo(GoResponsiveBreakpoints.compact);

  bool get isMedium => goResponsiveData.between(
    GoResponsiveBreakpoints.compact,
    GoResponsiveBreakpoints.medium,
  );

  bool get isExpanded => goResponsiveData.between(
    GoResponsiveBreakpoints.medium,
    GoResponsiveBreakpoints.expanded,
  );

  bool get isLargerThanCompact =>
      goResponsiveData.largerThan(GoResponsiveBreakpoints.compact);

  bool get isSmallerThanCompact =>
      goResponsiveData.smallerThan(GoResponsiveBreakpoints.compact);

  bool get isLargerOrEqualToCompact =>
      goResponsiveData.largerOrEqualTo(GoResponsiveBreakpoints.compact);

  bool get isSmallerOrEqualToCompact =>
      goResponsiveData.smallerOrEqualTo(GoResponsiveBreakpoints.compact);

  bool get isLargerThanMedium =>
      goResponsiveData.largerThan(GoResponsiveBreakpoints.medium);

  bool get isSmallerThanMedium =>
      goResponsiveData.smallerThan(GoResponsiveBreakpoints.medium);

  bool get isLargerOrEqualToMedium =>
      goResponsiveData.largerOrEqualTo(GoResponsiveBreakpoints.medium);

  bool get isSmallerOrEqualToMedium =>
      goResponsiveData.smallerOrEqualTo(GoResponsiveBreakpoints.medium);

  bool get isLargerThanExpanded =>
      goResponsiveData.largerThan(GoResponsiveBreakpoints.expanded);

  bool get isSmallerThanExpanded =>
      goResponsiveData.smallerThan(GoResponsiveBreakpoints.expanded);

  bool get isLargerOrEqualToExpanded =>
      goResponsiveData.largerOrEqualTo(GoResponsiveBreakpoints.expanded);

  bool get isSmallerOrEqualToExpanded =>
      goResponsiveData.smallerOrEqualTo(GoResponsiveBreakpoints.expanded);
}

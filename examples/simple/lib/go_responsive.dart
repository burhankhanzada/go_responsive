import 'package:flutter/widgets.dart';
import 'package:go_responsive/go_responsive.dart';
import 'package:go_responsive_annotation/go_responsive_annotation.dart';

part 'go_responsive.g.dart';

@goResponsive
const breakpoints = [
  GoResponsiveBreakpoint(size: 600, name: 'compact'),
  GoResponsiveBreakpoint(size: 840, name: 'medium'),
  GoResponsiveBreakpoint(size: double.maxFinite, name: 'expanded'),
];

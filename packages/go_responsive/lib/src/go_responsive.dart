import 'package:flutter/widgets.dart';

import 'data.dart';
import 'inherited_data.dart';

// ignore: avoid_classes_with_only_static_members
class GoResponsive {
  static GoResponsiveData of(BuildContext context) =>
      InheritedGoResponsiveData.of(context);
}

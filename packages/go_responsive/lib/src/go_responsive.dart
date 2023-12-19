import 'package:flutter/widgets.dart';

import 'data.dart';
import 'inherited_data.dart';

class GoResponsive {
  static GoResponsiveData of(BuildContext context) =>
      InheritedGoResponsiveData.of(context);
}

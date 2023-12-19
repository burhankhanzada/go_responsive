import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder goResponsiveBuilder(BuilderOptions options) => SharedPartBuilder(
      [GoResponsiveGenerator()],
      'go_responsive',
    );

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder goResponsiveBuilder(BuilderOptions options) => LibraryBuilder(
      GoResponsiveGenerator(),
      header: '''
import 'package:flutter/widgets.dart';
import 'package:go_responsive/go_responsive.dart';
''',
    );

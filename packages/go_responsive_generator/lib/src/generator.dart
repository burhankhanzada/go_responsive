import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:go_responsive_annotation/go_responsive_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_breakpoints_class.dart';
import 'generate_build_context_extension.dart';
import 'generate_widget.dart';

class GoResponsiveGenerator
    extends GeneratorForAnnotation<GoResponsiveAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is TopLevelVariableElement2) {
      final names = <String>[];
      final dartObject = element.computeConstantValue();
      final dartObjectList = dartObject!.toListValue()!;

      for (final i in dartObjectList) {
        final name = i.getField('name')!.toStringValue()!;
        names.add(name);
      }

      final emitter = DartEmitter.scoped(orderDirectives: true);

      final goResponsiveClass = generateBreakpointsClass(names);

      final widget = generateGoResponsiveWidget(names);

      final extension = generateGoResponsiveBuildContextExtensions(names);

      final library = Library(
        (b) => b..body.addAll([goResponsiveClass, widget, extension]),
      );

      final stringSink = library.accept(emitter);

      return DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      ).format(stringSink.toString());
    }

    return '// Generated Comment';
  }
}

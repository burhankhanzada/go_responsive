import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:go_responsive_annotation/go_responsive_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'generate_build_context_extension.dart';
import 'generate_strings.dart';
import 'generate_widget.dart';

class GoResponsiveGenerator extends GeneratorForAnnotation<GoResponsive> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final names = <String>[];

    if (element is TopLevelVariableElement) {
      final dartObject = element.computeConstantValue();
      final dartObjectList = dartObject!.toListValue()!;

      for (final i in dartObjectList) {
        final name = i.getField('name')!.toStringValue()!;
        names.add(name);
      }

      final emitter = DartEmitter.scoped(
        orderDirectives: true,
      );

      final fields = generateBreakpointNameStrngFields(names);

      final widget = generateGoResponsiveWidget(names);

      final extension = generateGoResponsiveBuildContextExtensions(names);

      final library = Library(
        (b) => b
          ..body.addAll([
            ...fields,
            widget,
            extension,
          ]),
      );

      final stringSink = library.accept(emitter);

      return DartFormatter().format(stringSink.toString());
    }

    return '// Generated Comment';
  }
}

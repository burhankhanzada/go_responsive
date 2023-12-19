import 'package:code_builder/code_builder.dart';

Class generateBreakpointsClass(List<String> names) {
  return Class(
    (b) => b
      ..fields.addAll(_generateFields(names))
      ..name = 'GoResponsiveBreakpoints',
  );
}

List<Field> _generateFields(List<String> names) {
  return names.map(
    (e) {
      return Field(
        (p0) => p0
          ..name = e
          ..static = true
          ..type = const Reference('String')
          ..assignment = Code("'$e'"),
      );
    },
  ).toList();
}

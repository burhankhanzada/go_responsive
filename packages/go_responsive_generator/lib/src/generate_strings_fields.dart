import 'package:code_builder/code_builder.dart';

List<Field> generateBreakpointNameStrngFields(List<String> names) {
  return names.map((e) {
    return Field(
      (p0) => p0
        ..name = e
        ..type = const Reference('String')
        ..assignment = Code("'$e'"),
    );
  }).toList();
}

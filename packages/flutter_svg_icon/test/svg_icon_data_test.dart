import 'package:flutter/foundation.dart';
import 'package:flutter_svg_icon/src/svg_icon_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('IconDataDiagnosticsProperty includes valueProperties in JSON', () {
    var property = SvgIconDataProperty('foo', const SvgIconData('path.svg'));

    final valueProperties = property.toJsonMap(
      const DiagnosticsSerializationDelegate(),
    )['valueProperties'] as Map<String, Object?>;

    expect(valueProperties['path'], 'path.svg');

    property = SvgIconDataProperty('foo', null);

    final json = property.toJsonMap(const DiagnosticsSerializationDelegate());
    expect(json.containsKey('valueProperties'), isFalse);
  });
}

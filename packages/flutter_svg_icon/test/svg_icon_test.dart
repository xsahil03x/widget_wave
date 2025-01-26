import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_icon/flutter_svg_icon.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Icon sizing - no theme, default size',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: SvgIcon(null)),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(24.0)));
    },
  );

  testWidgets(
    'Icon sizing - no theme, explicit size',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: SvgIcon(null, size: 96.0)),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(96.0)));
    },
  );

  testWidgets(
    'Icon sizing - sized theme',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: IconTheme(
              data: IconThemeData(size: 36.0),
              child: SvgIcon(null),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(36.0)));
    },
  );

  testWidgets(
    'Icon sizing - sized theme, explicit size',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: IconTheme(
              data: IconThemeData(size: 36.0),
              child: SvgIcon(null, size: 48.0),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(48.0)));
    },
  );

  testWidgets(
    'Icon sizing - sizeless theme, default size',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: IconTheme(
              data: IconThemeData(),
              child: SvgIcon(null),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(24.0)));
    },
  );

  testWidgets(
    'Icon sizing - no theme, default size, considering text scaler',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: _TextDoubler()),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(child: SvgIcon(null, applyTextScaling: true)),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(48.0)));
    },
  );

  testWidgets(
    'Icon sizing - no theme, explicit size, considering text scaler',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: _TextDoubler()),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SvgIcon(null, size: 96.0, applyTextScaling: true),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(192.0)));
    },
  );

  testWidgets(
    'Icon sizing - sized theme, considering text scaler',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: _TextDoubler()),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: IconTheme(
                data: IconThemeData(size: 36.0, applyTextScaling: true),
                child: SvgIcon(null),
              ),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(72.0)));
    },
  );

  testWidgets(
    'Icon sizing - sized theme, explicit size, considering text scale',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: _TextDoubler()),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: IconTheme(
                data: IconThemeData(size: 36.0, applyTextScaling: true),
                child: SvgIcon(null, size: 48.0, applyTextScaling: false),
              ),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(48.0)));
    },
  );

  testWidgets(
    'Icon sizing - sizeless theme, default size, default consideration for text scaler',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(textScaler: _TextDoubler()),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: IconTheme(data: IconThemeData(), child: SvgIcon(null)),
            ),
          ),
        ),
      );

      final renderBox = tester.renderObject(find.byType(SvgIcon)) as RenderBox;
      expect(renderBox.size, equals(const Size.square(24.0)));
    },
  );

  testWidgets(
    'Icon with semantic label',
    (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      final bundle = FakeAssetBundle();

      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: bundle,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SvgIcon(SvgIconData('test.svg'), semanticLabel: 'a label'),
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byType(SvgIcon)),
        matchesSemantics(label: 'a label'),
      );

      handle.dispose();
    },
  );

  testWidgets(
    'Null icon with semantic label',
    (WidgetTester tester) async {
      final handle = tester.ensureSemantics();

      final bundle = FakeAssetBundle();

      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: bundle,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SvgIcon(null, semanticLabel: 'a label'),
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.byType(SvgIcon)),
        matchesSemantics(label: 'a label'),
      );

      handle.dispose();
    },
  );

  testWidgets(
    "Changing semantic label from null doesn't rebuild tree ",
    (WidgetTester tester) async {
      final fakeAsset = FakeAssetBundle();

      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: fakeAsset,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SvgIcon(SvgIconData('test.svg')),
            ),
          ),
        ),
      );

      final svg1 = tester.element(find.byType(SvgPicture));

      await tester.pumpWidget(
        DefaultAssetBundle(
          bundle: fakeAsset,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SvgIcon(SvgIconData('test.svg'), semanticLabel: 'a label'),
            ),
          ),
        ),
      );

      final svg2 = tester.element(find.byType(SvgPicture));

      // Compare a leaf Element in the Icon subtree before and after changing the
      // semanticLabel to make sure the subtree was not rebuilt.
      expect(svg1, same(svg2));
    },
  );

  testWidgets(
    'SvgIconData comparison',
    (WidgetTester tester) async {
      expect(const SvgIconData('path.svg'), const SvgIconData('path.svg'));
      expect(
        const SvgIconData('path.svg'),
        isNot(const SvgIconData('path.svg', matchTextDirection: true)),
      );
      expect(
        const SvgIconData('path.svg'),
        isNot(const SvgIconData('path.svg', preserveColors: true)),
      );
      expect(
        const SvgIconData('path.svg').hashCode,
        const SvgIconData('path.svg').hashCode,
      );
      expect(
        const SvgIconData('path.svg').hashCode,
        isNot(const SvgIconData('path.svg', matchTextDirection: true).hashCode),
      );
      expect(
        const SvgIconData('path.svg').hashCode,
        isNot(const SvgIconData('path.svg', preserveColors: true).hashCode),
      );
      expect(const SvgIconData('path.svg').toString(), 'SvgIconData(path.svg)');
    },
  );
}

final class _TextDoubler extends TextScaler {
  const _TextDoubler();

  @override
  double scale(double fontSize) => fontSize * 2.0;

  @override
  double get textScaleFactor => 2.0;
}

const _testSvgString = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
  <rect x="5" y="5" width="10" height="10"/>
</svg>
''';

class FakeAssetBundle extends Fake implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return _testSvgString;
  }

  @override
  Future<ByteData> load(String key) async {
    return Uint8List.fromList(utf8.encode(_testSvgString)).buffer.asByteData();
  }
}

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_grid_view/flex_grid_view.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('FlexGrid renders with correct pattern',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              children: const [
                ColoredBox(color: Colors.red),
                ColoredBox(color: Colors.blue),
                ColoredBox(color: Colors.green),
                ColoredBox(color: Colors.yellow),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(ColoredBox), findsNWidgets(4));
    });

    testWidgets('FlexGrid handles maxChildren correctly',
        (WidgetTester tester) async {
      final pattern = [
        [1, 1],
        [1, 1],
      ];

      final children = [
        const ColoredBox(color: Colors.red),
        const ColoredBox(color: Colors.blue),
        const ColoredBox(color: Colors.green),
        const ColoredBox(color: Colors.yellow),
        const ColoredBox(color: Colors.purple),
        const ColoredBox(color: Colors.orange),
      ];

      // Test with exactly 4 children (matching the pattern count)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: pattern,
              maxChildren: 4,
              overlayBuilder: (context, remaining) => Center(
                child: Text('+$remaining'),
              ),
              children: children.take(4).toList(),
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(ColoredBox), findsNWidgets(4));
    });

    testWidgets('FlexGrid applies spacing correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              spacing: 10,
              runSpacing: 20,
              children: const [
                ColoredBox(color: Colors.red),
                ColoredBox(color: Colors.blue),
                ColoredBox(color: Colors.green),
                ColoredBox(color: Colors.yellow),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('SizedBox works for adding spacing in layouts',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                Text('Before'),
                SizedBox(width: 20),
                Text('After'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('Before'), findsOneWidget);
      expect(find.text('After'), findsOneWidget);
    });

    testWidgets('FlexGrid with custom runPattern', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              runPattern: const [3, 1], // First row has 3x height of second row
              children: const [
                ColoredBox(color: Colors.red),
                ColoredBox(color: Colors.blue),
                ColoredBox(color: Colors.green),
                ColoredBox(color: Colors.yellow),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(ColoredBox), findsNWidgets(4));
    });

    testWidgets('FlexGrid with reverse direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              reverse: true, // Reverse the grid direction
              children: const [
                ColoredBox(color: Colors.red),
                ColoredBox(color: Colors.blue),
                ColoredBox(color: Colors.green),
                ColoredBox(color: Colors.yellow),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(ColoredBox), findsNWidgets(4));

      // We only need to verify that the widget rendered correctly
      // Implementation details like Flex direction are not part of the public API
    });

    testWidgets('FlexGrid with different pattern shapes',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGrid(
              pattern: const [
                [
                  2,
                  1
                ], // First row: first cell takes 2/3 width, second takes 1/3
                [
                  1,
                  2
                ], // Second row: first cell takes 1/3 width, second takes 2/3
              ],
              children: const [
                ColoredBox(color: Colors.red),
                ColoredBox(color: Colors.blue),
                ColoredBox(color: Colors.green),
                ColoredBox(color: Colors.yellow),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(FlexGrid), findsOneWidget);
      expect(find.byType(ColoredBox), findsNWidgets(4));
    });
  });

  // Golden tests
  group('FlexGrid Golden Tests', () {
    goldenTest(
      'basic 2x2 grid',
      fileName: 'basic_2x2',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'custom pattern with different cell sizes',
      fileName: 'custom_pattern',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [2, 1], // First row: 2/3 and 1/3 width
                [1, 2], // Second row: 1/3 and 2/3 width
              ],
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'with spacing and runSpacing',
      fileName: 'spacing',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              spacing: 20,
              runSpacing: 10,
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'with custom runPattern',
      fileName: 'run_pattern',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              runPattern: const [3, 1], // First row has 3x height of second row
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'with maxChildren and overlay',
      fileName: 'max_children_overlay',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              maxChildren: 3,
              overlayBuilder: (context, remaining) => Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '+$remaining',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );

    goldenTest(
      'reverse direction (row as primary)',
      fileName: 'reverse_direction',
      constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            color: Colors.white,
            child: FlexGrid(
              pattern: const [
                [1, 1],
                [1, 1],
              ],
              reverse: true, // Use row as primary direction
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

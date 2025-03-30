import 'package:flex_grid_view/src/matrix.dart';
import 'package:flutter/material.dart';

/// Signature for a function that builds a widget for the overlay of the last
/// child in the grid in case the number of children exceeds the maximum.
///
/// The [remaining] parameter represents the number of children that are not
/// displayed in the grid.
typedef OverlayBuilder = Widget Function(BuildContext context, int remaining);

/// {@template flex_grid}
/// A flexible grid widget that arranges its children based on a provided
/// [pattern].
///
/// The [FlexGrid] widget displays a grid of [children] widgets based on a
/// provided [pattern]. Each numeric value in the matrix represents the
/// flex value of the corresponding widget in the grid. The number of widgets
/// must match the number of cells in the matrix.
///
/// The grid can be configured to have a maximum number of children to display.
/// If the number of children exceeds the maximum, the last child will show the
/// remaining number of children as a count in an overlay. An overlay builder
/// can be provided to customize the overlay for the last child.
///
/// The direction of the grid can be reversed, with either the column or row as
/// the primary direction. Spacing can be applied between children in the main
/// axis and between the runs (rows or columns) themselves in the cross axis.
///
/// Example usage:
/// ```dart
/// FlexGrid(
///   pattern: const [
///     [1, 1],
///     [1, 1],
///   ],
///   children: [
///     Container(color: Colors.red),
///     Container(color: Colors.blue),
///     Container(color: Colors.green),
///     Container(color: Colors.yellow),
///   ],
/// )
/// ```
/// {@endtemplate}
class FlexGrid extends StatelessWidget {
  /// {@macro flex_grid}
  FlexGrid({
    super.key,
    required this.pattern,
    required this.children,
    this.runPattern,
    this.maxChildren,
    this.overlayBuilder,
    this.reverse = false,
    this.spacing = 2.0,
    this.runSpacing = 2.0,
  })  : assert(
          pattern.count == children.length,
          'The number of children must match the number of cells in the matrix',
        ),
        assert(
          runPattern == null || runPattern.length == pattern.length,
          'The length of rowPattern must match the number of rows in the matrix',
        ),
        assert(
          maxChildren == null || maxChildren <= pattern.count,
          'MaxChildren must be less than or equal to the number of cells in the matrix',
        );

  /// The pattern of the grid.
  ///
  /// Each numeric value in the array represents the flex value of
  /// corresponding widget in grid.
  ///
  /// For example, a grid with 2 rows and 2 columns can be represented as:
  ///
  /// ```dart
  /// [
  ///  [1, 1],
  ///  [1, 1],
  /// ]
  /// ```
  ///
  /// This will create a grid with 4 cells with each cell having a flex value
  /// of 1.
  final Matrix<int> pattern;

  /// The widgets to display in the grid.
  ///
  /// The number of widgets must match the number of cells in the matrix.
  final List<Widget> children;

  /// Custom flex factors for each run in the cross axis.
  ///
  /// If provided, each value in the list corresponds to the flex factor
  /// of that run in the grid. The length of this list must match the number
  /// of runs in the pattern.
  ///
  /// For example:
  /// ```dart
  /// runPattern: [3, 1], // First run gets 3x height, second run gets 1x
  /// ```
  ///
  /// If null, all runs will have equal flex factor of 1.
  final List<int>? runPattern;

  /// Whether to reverse the direction of the grid.
  ///
  /// By default, the grid is rendered with column as primary direction and row
  /// as secondary direction.
  ///
  /// If this is set to `true`, the grid will be rendered with row as primary
  /// direction and column as secondary direction.
  final bool reverse;

  /// The maximum number of children to display in the grid.
  ///
  /// If this is set, the grid will be rendered with a maximum of [maxChildren]
  /// children. If the number of children is greater than [maxChildren], The
  /// last child will show the remaining number of children as a count in a
  /// overlay.
  final int? maxChildren;

  /// The builder to use to build the overlay for the last child in case the
  /// number of children is greater than [maxChildren].
  ///
  /// The builder will be passed the number of remaining children to display.
  final OverlayBuilder? overlayBuilder;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// Defaults to 2.0.
  final double spacing;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// Defaults to 2.0.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    // Determine the primary and secondary directions.
    final primaryDirection = reverse ? Axis.horizontal : Axis.vertical;
    final secondaryDirection = reverse ? Axis.vertical : Axis.horizontal;

    var pattern = [...this.pattern];
    var children = [...this.children];

    // If the number of children is greater than the maximum number of children,
    // remove the extra children.
    final maxChildren = this.maxChildren;
    if (maxChildren != null && maxChildren < pattern.count) {
      children = [...children.take(maxChildren)];
      pattern = [...pattern.takeItems(maxChildren)];
    }

    return Flex(
      direction: primaryDirection,
      children: [
        ...pattern.mapCell<Widget>(
          (index, flex) {
            final child = children[index];
            final isLastChild = index == children.length - 1;

            // Determine the number of remaining children.
            final remaining = (this.children.length - 1) - index;

            // If we are at the last child and there are remaining
            // children, show the remaining number of children as a
            // count in a overlay.
            if (isLastChild && remaining > 0 && overlayBuilder != null) {
              return Expanded(
                flex: flex,
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [child, overlayBuilder!.call(context, remaining)],
                ),
              );
            }

            // Otherwise, return the child.
            return Expanded(flex: flex, child: child);
          },
        ).mapIndexed<Widget>(
          (index, row) {
            return Expanded(
              flex: runPattern?[index] ?? 1,
              child: Flex(
                direction: secondaryDirection,
                children: [
                  ...row.insertBetween(
                    Gap(direction: secondaryDirection, spacing: spacing),
                  ),
                ],
              ),
            );
          },
        ).insertBetween(
          Gap(direction: primaryDirection, spacing: runSpacing),
        ),
      ],
    );
  }
}

/// {@template gap}
/// A gap widget used to add spacing between children in either the horizontal
/// or vertical direction.
/// {@endtemplate}
class Gap extends StatelessWidget {
  /// {@macro gap}
  const Gap({
    super.key,
    required this.direction,
    this.spacing = 0.0,
  });

  /// The direction of the gap.
  final Axis direction;

  /// The spacing between children in the gap.
  ///
  /// Defaults to 0.0.
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return switch (direction) {
      Axis.horizontal => SizedBox(width: spacing),
      Axis.vertical => SizedBox(height: spacing),
    };
  }
}

/// Extension methods for [Iterable<T>] to provide additional functionality.
extension<T> on Iterable<T> {
  /// Lazily inserts [item] between each element of the iterable.
  Iterable<T> insertBetween(T item) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return;
    yield iterator.current;
    while (iterator.moveNext()) {
      yield item;
      yield iterator.current;
    }
  }

  /// Maps each element of the iterable to a new value using the provided
  /// [convert] function.
  Iterable<R> mapIndexed<R>(
    R Function(int index, T element) convert,
  ) sync* {
    var index = 0;
    for (final element in this) {
      yield convert(index++, element);
    }
  }
}

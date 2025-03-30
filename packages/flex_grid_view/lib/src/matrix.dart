/// {@template matrix}
/// A matrix represents a 2D array.
/// {@endtemplate}
typedef Matrix<T> = Iterable<Iterable<T>>;

/// A matrix extension that provides additional functionality for matrix
/// operations.
extension MatrixExtension<T> on Matrix<T> {
  /// Returns the total number of items in the matrix.
  int get count => fold(0, (sum, row) => sum + row.length);

  /// Creates a matrix with at most [count] elements from this matrix.
  ///
  /// The returned matrix may contain fewer than [count] elements, if this
  /// matrix contains fewer than [count] elements.
  Matrix<T> takeItems(int count) {
    if (count <= 0) return [];

    final matrix = <List<T>>[];
    var remaining = count;

    for (final row in this) {
      if (remaining <= 0) break;

      final newRow = [...row.take(remaining)];
      matrix.add(newRow);
      remaining -= newRow.length;
    }

    return matrix;
  }

  /// Maps each cell in the matrix to a new value using the provided
  /// [transform] function.
  Matrix<R> mapCell<R>(
    R Function(int cellIndex, T cell) transform,
  ) {
    var absIndex = 0;
    return map((row) => row.map((cell) => transform(absIndex++, cell)));
  }
}

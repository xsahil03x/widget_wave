import 'package:flutter_test/flutter_test.dart';
import 'package:flex_grid/src/matrix.dart';

void main() {
  group('MatrixExtension', () {
    test('count returns total number of items in matrix', () {
      final matrix = [
        [1, 2, 3],
        [4, 5],
        [6, 7, 8, 9],
      ];
      
      expect(matrix.count, 9);
    });

    test('count returns 0 for empty matrix', () {
      final matrix = <List<int>>[];
      expect(matrix.count, 0);
    });

    test('takeItems limits matrix to specified count', () {
      final matrix = [
        [1, 2, 3],
        [4, 5],
        [6, 7, 8, 9],
      ];
      
      final result = matrix.takeItems(5);
      expect(result, [
        [1, 2, 3],
        [4, 5],
      ]);
      expect(result.count, 5);
    });

    test('takeItems handles count larger than matrix size', () {
      final matrix = [
        [1, 2],
        [3, 4],
      ];
      
      final result = matrix.takeItems(10);
      expect(result, matrix);
      expect(result.count, 4);
    });

    test('takeItems handles count of 0', () {
      final matrix = [
        [1, 2],
        [3, 4],
      ];
      
      final result = matrix.takeItems(0);
      expect(result, []);
      expect(result.count, 0);
    });

    test('mapCell transforms each cell with correct index', () {
      final matrix = [
        [1, 2],
        [3, 4],
      ];
      
      final result = matrix.mapCell((index, cell) => '$index:$cell');
      
      expect(result, [
        ['0:1', '1:2'],
        ['2:3', '3:4'],
      ]);
    });
  });
} 
import 'cell.dart';

class CellGrid {
  late List<List<Cell>> _cells;
  static final List<List<int>> _neighbors = [
    [-1,  1], [0,  1], [1,  1],
    [-1,  0],          [1,  0],
    [-1, -1], [0, -1], [1, -1],
  ];

  CellGrid(int length, int width) {
    _cells = [];
  }

  int countAliveNeighbors(Cell cell) {
    int numberOfLiveNeighbors = 0;
    final int x = cell.x;
    final int y = cell.y;

    for(final List<int> neighbor in _neighbors) {
      final int neighborX = x + neighbor.first;
      final int neighborY = y + neighbor.last;
      final Cell neighborCell = _cells[neighborX][neighborY];

      if (neighborCell.isAlive) numberOfLiveNeighbors++;
    }

    return numberOfLiveNeighbors;
  }
}
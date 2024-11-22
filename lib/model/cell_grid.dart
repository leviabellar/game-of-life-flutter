import 'cell.dart';

class CellGrid {
  late List<List<Cell>> _cells;
  static final List<List<int>> _neighbors = [
    [-1,  1], [0,  1], [1,  1],
    [-1,  0],          [1,  0],
    [-1, -1], [0, -1], [1, -1],
  ];

  CellGrid(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
    int rows = bottomRightY - topLeftY + 1;
    int cols = bottomRightX - topLeftX + 1; // Instantiate the 2D list with the desired dimensions

    _cells = List.generate(
      rows, (i) => List.generate(
          cols, (j) => Cell.dead(
          cellGrid: this,
          x: topLeftX + j,
          y: topLeftY + i,
        )
      )
    );
  }

  void addCellAt({required int x, required int y}) {
    _cells[x][y] = Cell.dead(cellGrid: this, x: x, y: y);
  }

  void reviveCellAt({required int x, required int y}) {
    _cells[x][y].revive();
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
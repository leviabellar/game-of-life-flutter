

import 'package:game_of_life/model/cell_grid.dart';

class Cell {
  bool isAlive;
  CellGrid _cellGrid;
  int _x;
  int _y;

  Cell({required this.isAlive, required cellGrid, required x, required y}) : _cellGrid = cellGrid, _x = x, _y = y;

  factory Cell.alive({required cellGrid, x, y,}) => Cell(isAlive: true, cellGrid: cellGrid, x: x, y: y,);
  factory Cell.dead({required cellGrid, x, y,}) => Cell(isAlive: false, cellGrid: cellGrid, x: x, y: y,);

  void revive() => isAlive = true;
  void kill() => isAlive = false;


  // Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  // Any live cell with two or three live neighbours lives on to the next generation.
  // Any live cell with more than three live neighbours dies, as if by overpopulation.
  // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  bool shouldLive() {
    final int liveCellNeighbors = _cellGrid.countAliveNeighbors(this);

    if (liveCellNeighbors == 3) return true;
    if (isAlive && liveCellNeighbors == 2) return true;
    return false;
  }

  int get x => _x;
  int get y => _y;
}
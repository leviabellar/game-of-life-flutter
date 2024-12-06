import 'package:flutter/material.dart';

import 'cell.dart';

class CellBuilder extends StatelessWidget {
  const CellBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, bool> cellStatus = {};

    void reviveCell(int x, int y) {
      cellStatus['$x,$y'] = true;
    }

    bool toggleCell(int x, int y) {
      cellStatus['$x,$y'] = !(cellStatus['$x,$y'] ?? false);
      return cellStatus['$x,$y'] ?? false;
    }

    return InteractiveViewer.builder(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      builder: (context, viewport) {
        final List<Widget> cells = [];
        const double size = 30.0;

        // First get the height and width of the viewport
        final height = viewport.point3.y - viewport.point0.y;
        final width = viewport.point1.x - viewport.point0.x;

        // Then calculate the number of rows and columns
        final row = (height / size).ceil();
        final column = (width / size).ceil();

        // Then calculate the leftmost and topmost cell
        final topMost = (viewport.point0.y / size).floor();
        final leftMost = (viewport.point0.x / size).floor();

        // Then create the cells
        List.generate(row + 1, (i) {
          List.generate(column + 1, (j) {
            final x = leftMost + j;
            final y = topMost + i;
            cells.add(
              Cell(
                x: x,
                y: y,
                isAlive: cellStatus['$x,$y'] ?? false,
                size: size,
                onTap: toggleCell,
                key: ValueKey('$x,$y'),
              ),
            );
          });
        },);

        return SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            clipBehavior: Clip.none,
            children: cells,
          ),
        );
      },
    );
  }
}

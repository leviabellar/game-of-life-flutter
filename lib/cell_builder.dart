import 'package:flutter/material.dart';

import 'cell.dart';

class CellBuilder extends StatelessWidget {
  const CellBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            cells.add(
              Cell(
                x: leftMost + j,
                y: topMost + i,
                size: size,
              ),
            );
          });
        },);

        return SizedBox(
          height: 1,
          width: 1,
          child: Stack(
            clipBehavior: Clip.none,
            children: cells,
          ),
        );
      },
    );
  }
}

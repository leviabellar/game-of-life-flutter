import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Quad, Vector3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: _IVBuilderExample(),
      ),
    );
  }
}

class _IVBuilderExample extends StatefulWidget {
  const _IVBuilderExample();

  @override
  State<_IVBuilderExample> createState() => _IVBuilderExampleState();
}

class _IVBuilderExampleState extends State<_IVBuilderExample> {
  static const double _cellWidth = 80.0;
  static const double _cellHeight = 80.0;

  // Returns the axis aligned bounding box for the given Quad, which might not
  // be axis aligned.
  Rect axisAlignedBoundingBox(Quad quad) {
    double xMin = quad.point0.x;
    double xMax = quad.point0.x;
    double yMin = quad.point0.y;
    double yMax = quad.point0.y;
    for (final Vector3 point in <Vector3>[
      quad.point1,
      quad.point2,
      quad.point3,
    ]) {
      if (point.x < xMin) {
        xMin = point.x;
      } else if (point.x > xMax) {
        xMax = point.x;
      }

      if (point.y < yMin) {
        yMin = point.y;
      } else if (point.y > yMax) {
        yMax = point.y;
      }
    }

    return Rect.fromLTRB(xMin, yMin, xMax, yMax);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return InteractiveViewer.builder(
            boundaryMargin: const EdgeInsets.all(double.infinity),
            builder: (BuildContext context, Quad viewport) {
              print('viewport 0 -> ${viewport.point0}');
              print('viewport 1 -> ${viewport.point1}');
              print('viewport 2 -> ${viewport.point2}');
              print('viewport 3 -> ${viewport.point3}');

              return _TableBuilder(
                cellWidth: _cellWidth,
                cellHeight: _cellHeight,
                viewport: axisAlignedBoundingBox(viewport),
                builder: (BuildContext context, int row, int column) {
                  return Container(
                    height: _cellHeight,
                    width: _cellWidth,
                    color: row % 2 + column % 2 == 1
                        ? Colors.white
                        : Colors.grey.withOpacity(0.1),
                    child: Align(
                      child: Text('$row x $column'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

typedef _CellBuilder = Widget Function(
    BuildContext context, int row, int column);

class _TableBuilder extends StatelessWidget {
  const _TableBuilder({
    required this.cellWidth,
    required this.cellHeight,
    required this.viewport,
    required this.builder,
  });

  final double cellWidth;
  final double cellHeight;
  final Rect viewport;
  final _CellBuilder builder;

  @override
  Widget build(BuildContext context) {
    final int firstRow = (viewport.top / cellHeight).floor();
    final int lastRow = (viewport.bottom / cellHeight).ceil();
    final int firstCol = (viewport.left / cellWidth).floor();
    final int lastCol = (viewport.right / cellWidth).ceil();

    // This will create and render exactly (lastRow - firstRow) * (lastCol - firstCol) cells

    return SizedBox(
      // Stack needs constraints, even though we then Clip.none outside of them.
      // InteractiveViewer.builder always sets constrained to false, giving infinite constraints to the child.
      // See: https://api.flutter.dev/flutter/widgets/InteractiveViewer/constrained.html
      width: 1,
      height: 1,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (int row = firstRow; row < lastRow; row++)
            for (int col = firstCol; col < lastCol; col++)
              Positioned(
                left: col * cellWidth,
                top: row * cellHeight,
                child: builder(context, row, col),
              ),
        ],
      ),
    );
  }
}
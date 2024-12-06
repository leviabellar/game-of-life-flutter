import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: InteractiveViewer.builder(
                boundaryMargin: const EdgeInsets.all(double.infinity),
                builder: (context, viewport) {
                  final List<Widget> cells = [];

                  // First get the height and width of the viewport
                  final height = viewport.point3.y - viewport.point0.y;
                  final width = viewport.point1.x - viewport.point0.x;

                  // Then calculate the number of rows and columns
                  final row = (height / 30).ceil();
                  final column = (width / 30).ceil();

                  // Then calculate the leftmost and topmost cell
                  final topMost = (viewport.point0.y / 30).floor();
                  final leftMost = (viewport.point0.x / 30).floor();

                  // Then create the cells
                  List.generate(row + 1, (i) {
                    List.generate(column + 1, (j) {
                      cells.add(
                        Cell(x: leftMost + j, y: topMost + i),
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
              ),
            ),
            const SizedBox(
              height: 100,
              child: ColoredBox(
                color: Colors.black,
                child: Center(
                  child: Text('This is a black box'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x * 30.0,
      top: y * 30.0,
      child: SizedBox(
        height: 30,
        width: 30,
        child: ColoredBox(
          color: Colors.white,
          child: Center(
            child: Text('$x, $y', style: const TextStyle(fontSize: 8),),
          ),
        ),
      ),
    );
  }
}
